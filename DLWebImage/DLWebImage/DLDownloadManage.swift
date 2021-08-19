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
        
    var taskArray : [DLDownloadTask] = []
    
    var downloadArray : [DLDownloader] = []
    
    public static func shareInstance() -> DLDownloadManage {
        return downloadManage
    }
    
    func taskRun() {
        autoreleasepool {
            let task = taskArray.first!
            let view = task.taskView
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
            if downloadArray.count <= 4 {
                let download = DLDownloader.init()
                download.index = downloadArray.count
                download.state = .finish
                downloadArray.append(download)
            }
            if let download = searchFreeDownload() {
                taskArray.removeFirst()
                download.download(url: task.url, scaleType: task.scaleType, size: task.taskSize) { (progress) in
                    
                } completionBlock: { (image) in
                    download.taskViewSize = .zero
                    download.state = .finish
                    self.downloadArray[download.index] = download
                    DispatchQueue.main.async {[weak self] in
                        if let dataImage = image {
                            self?.setViewImage(view: view, image: dataImage, state: task.state)
                        }
                        if self?.taskArray.count ?? 0 > 0 {
                            self?.taskRun()
                        }
                    }
                }
                download.resumeDown()
            }
        }
    }
        
    func setViewImage(view : UIView?, image : UIImage, state : UIControl.State) {
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
    
    func searchFreeDownload() -> DLDownloader? {
        var download : DLDownloader?
        for down in downloadArray {
            if down.state == .finish {
                download = down
                break
            }
        }
        return download
    }
    
    func addTask(task : DLDownloadTask) {
        guard searchCacheImage(task: task) == false else {
            return
        }
        taskArray.append(task)
        if downloadArray.count <= 4 || searchFreeDownload() != nil{
            taskRun()
        }
    }
    
    func searchRepetitiveDownload(task : DLDownloadTask) -> Bool {
        for download in downloadArray {
            if download.urlStr == task.url {
                return true
            }
        }
        return false
    }
    
    func searchCacheImage(task : DLDownloadTask) -> Bool {
        if let image = DLMemoryCache.shareInstance().object(forKey: task.cacheKey) {
            setViewImage(view: task.taskView, image: image, state: task.state)
            return true
        }
        return false
    }
}
