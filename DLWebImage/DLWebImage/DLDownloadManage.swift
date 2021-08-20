//
//  DLDownloadManage.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import UIKit
import UIKit

class DLDownloadManage: NSObject {
                
    private static let downloadManage = DLDownloadManage.init()
        
    private var taskArray : [DLWebImageView] = []
    
    private var downloadArray : [DLDownloader] = []
    
    private var taskCount = 0
    
    public static func shareInstance() -> DLDownloadManage {
        return downloadManage
    }
    
    override init() {
        super.init()
        taskCount = getDeviceCpuCount() * 2
    }
    
    private func taskRun() {
        autoreleasepool {
            let task = taskArray.first!
            guard searchCacheImage(task: task) == false else {
                taskArray.removeFirst()
                if self.taskArray.count > 0 {
                    self.taskRun()
                }
                return
            }
            guard searchRepetitiveDownload(task: task) == false else {
                taskArray.removeFirst()
                taskArray.append(task)
                return
            }
            if downloadArray.count <= taskCount {
                let download = DLDownloader.init()
                download.index = downloadArray.count
                download.state = .finish
                downloadArray.append(download)
            }
            if let download = searchFreeDownload() {
                taskArray.removeFirst()
                download.download(url: task.url, scaleType: task.scaleType, size: task.size, progressBlock: task.progressBlock) { (image) in
                    download.taskViewSize = .zero
                    download.state = .finish
                    self.downloadArray[download.index] = download
                    DispatchQueue.main.async {[weak self] in
                        task.spinner?.stopAnimating()
                        if let decodeImage = DLImageCache.shareInstance().object(forKey: task.cacheKey) {
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
        
    private func setViewImage(view : UIView?, image : UIImage, state : UIControl.State) {
        if view is UIImageView {
            if let imageView : UIImageView = view as? UIImageView {
                imageView.image = image
            }
        }else if view is UIButton {
            if let btn : UIButton = view as? UIButton {
                btn.setImage(image, for: state)
            }
        }else {
            view?.backgroundColor = UIColor.init(patternImage: image)
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
    
    func addTask(task : DLWebImageView) {
        if task.url.count == 0 {
            setViewImage(view: task.view, image: task.failImage ?? UIImage.init(), state: task.state)
            task.failBlock?()
            return
        }
        guard searchCacheImage(task: task) == false else {
            return
        }
        taskArray.append(task)
        if downloadArray.count <= 4 || searchFreeDownload() != nil{
            taskRun()
        }
    }
    
    private func searchRepetitiveDownload(task : DLWebImageView) -> Bool {
        for download in downloadArray {
            if download.urlStr == task.url {
                return true
            }
        }
        return false
    }
    
    private func searchCacheImage(task : DLWebImageView) -> Bool {
        if let image = DLImageCache.shareInstance().object(forKey: task.cacheKey) {
            task.spinner?.stopAnimating()
            setViewImage(view: task.view, image: image, state: task.state)
            return true
        }
        return false
    }
}
