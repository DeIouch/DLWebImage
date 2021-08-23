import UIKit
import UIKit

class DLDownloadManage: NSObject {
                
    private static let downloadManage = DLDownloadManage.init()
        
    private var taskArray : [DLWebImage] = []
    
    private var downloadArray : [DLDownloader] = []
    
    private var taskCount = 0
    
    public static func shareInstance() -> DLDownloadManage {
        return downloadManage
    }
    
    override init() {
        super.init()
//        taskCount = getDeviceCpuCount() * 2
        taskCount = 1
    }
    
    
    private func findTask() -> Int {
        objc_sync_exit(taskArray)
        var index = taskArray.count - 1
        for i in 0...taskArray.count - 1 {
            let taskView = taskArray[index - i]
            if taskView.view?.displayedInScreen() == true {
                index = taskArray.count - 1 - i
                break
            }
        }
        objc_sync_enter(taskArray)
        return index
    }
    func taskRun() {
        autoreleasepool {
            let index = findTask()
            let task = taskArray[index]
            guard searchCacheImage(task: task) == false else {
                objc_sync_exit(taskArray)
                taskArray.remove(at: index)
                objc_sync_enter(taskArray)
                if self.taskArray.count > 0 {
                    self.taskRun()
                }
                return
            }
            guard searchRepetitiveDownload(task: task) == false else {
                objc_sync_exit(taskArray)
                taskArray.remove(at: index)
                taskArray.append(task)
                objc_sync_enter(taskArray)
                return
            }
            if downloadArray.count <= taskCount {
                let download = DLDownloader.init()
                download.index = downloadArray.count
                download.state = .finish
                downloadArray.append(download)
            }
            if let download = searchFreeDownload() {
                objc_sync_exit(taskArray)
                taskArray.remove(at: index)
                objc_sync_enter(taskArray)
                download.download(url: task.url, scaleType: task.scaleType, size: task.size, progressBlock: task.progressBlock) { (image) in
                    download.taskViewSize = .zero
                    download.state = .finish
                    self.downloadArray[download.index] = download
                    DispatchQueue.main.async {[weak self] in
                        task.spinner?.stopAnimating()
                        if let decodeImage = DLImageCache.shareInstance().object(forKey: task.view?.cacheKey ?? "") {
                            self?.setViewImage(view: task.view, image: decodeImage, state: task.state)
                        }
                        if self?.taskArray.count ?? 0 > 0 {
                            self?.taskRun()
                        }
                    }
                    task.completionBlock?(image)
                } failBlock: {
                    download.taskViewSize = .zero
                    download.state = .finish
                    self.downloadArray[download.index] = download
                    DispatchQueue.main.async {[weak self] in
                        task.spinner?.stopAnimating()
                        if let dataImage = task.failImage {
                            self?.setViewImage(view: task.view, image: dataImage, state: task.state)
                        }
                        if self?.taskArray.count ?? 0 > 0 {
                            self?.taskRun()
                        }
                    }
                    task.failBlock?()
                }
                download.resumeDown()
            }
        }
    }
    
    private func getDeviceCpuCount() -> Int {
        var ncpu: UInt = UInt(0)
        var len: size_t = MemoryLayout.size(ofValue: ncpu)
        sysctlbyname("hw.ncpu", &ncpu, &len, nil, 0)
        return Int(ncpu)
    }
        
    private func setViewImage(view : UIView?, image : UIImage?, state : UIControl.State) {
        if view is UIImageView {
            if let imageView : UIImageView = view as? UIImageView {
                imageView.image = image
            }
        }else if view is UIButton {
            if let btn : UIButton = view as? UIButton {
                btn.setImage(image, for: state)
            }
        }else {
            view?.backgroundColor = UIColor.init(patternImage: image ?? UIImage.init())
        }
    }
    
    private func searchFreeDownload() -> DLDownloader? {
        var download : DLDownloader?
        for down in downloadArray {
            if down.state == .finish {
                download = down
                break
            }
        }
        return download
    }
    
    func addTask(task : DLWebImage) {
        if task.url.count == 0 {
            setViewImage(view: task.view, image: task.failImage, state: task.state)
            task.spinner?.stopAnimating()
            task.failBlock?()
            return
        }
        guard searchCacheImage(task: task) == false else {
            return
        }
        objc_sync_exit(taskArray)
        taskArray.append(task)
        objc_sync_enter(taskArray)
        setViewImage(view: task.view, image: task.placeholderImage, state: task.state)
        if downloadArray.count <= 4 || searchFreeDownload() != nil{
            taskRun()
        }
    }
    
    private func searchRepetitiveDownload(task : DLWebImage) -> Bool {
        for download in downloadArray {
            if download.urlStr == task.url {
                return true
            }
        }
        return false
    }
    
    private func searchCacheImage(task : DLWebImage) -> Bool {
        if let image = DLImageCache.shareInstance().object(forKey: task.view?.cacheKey ?? "") {
            task.spinner?.stopAnimating()
            setViewImage(view: task.view, image: image, state: task.state)
            return true
        }
        return false
    }
}
