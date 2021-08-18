//
//  DLDownloadManage.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import UIKit
import UIKit

class DLDownloadManage: NSObject {
                
    let filePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/"
    
    private static let downloadManage = DLDownloadManage.init()
        
    var taskArray : [UIImageView] = []
    
    var downloadArray : [DLDownloader] = []
        
    let fileManager : FileManager = FileManager.init()
    
    var cache : NSCache = NSCache<NSString, UIImage>.init()
                
    private override init() {
        super.init()
        fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)
    }
    
    public static func shareInstance() -> DLDownloadManage {
        return downloadManage
    }
    
    func taskRun() {
        autoreleasepool {
            let imageView = taskArray.first!
            guard searchCacheImage(imageView: imageView) == false else {
                taskArray.removeFirst()
                if self.taskArray.count > 0 {
                    self.taskRun()
                }
                return
            }
            guard searchRepetitiveDownload(imageView: imageView) == false else {
                taskArray.removeFirst()
                taskArray.append(imageView)
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
                download.download(imageView: imageView, size: imageView.frame.size, filePath: filePath + imageView.md5Key) { (progress) in
                    
                } completionBlock: { (image) in
                    download.taskImageView = nil
                    download.taskViewSize = .zero
                    download.state = .finish
                    self.downloadArray[download.index] = download
                    DispatchQueue.main.async {[weak self] in
                        if let images = image {
                            self?.cache.setObject(images, forKey: (imageView.urlKey + "\(imageView.scaleType)").md5() as NSString)
                            self?.setViewImage(view: imageView, image: images)
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
        
    func setViewImage(view : UIView, image : UIImage) {
        if view is UIImageView {
            if let imageView : UIImageView = view as? UIImageView {
                imageView.image = image
            }
        }else if view is UIButton {
            if let btn : UIButton = view as? UIButton {
                btn.setImage(image, for: .normal)
            }
        }else if view is UILabel {
            if let lbl : UILabel = view as? UILabel {
                lbl.backgroundColor = UIColor.init(patternImage: image)
            }
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
    
    func addTask(view : UIImageView) {
        guard searchCacheImage(imageView: view) == false else {
            return
        }
        taskArray.append(view)
        if downloadArray.count <= 4 || searchFreeDownload() != nil{
            taskRun()
        }
    }
    
    func searchRepetitiveDownload(imageView : UIImageView) -> Bool {
        for download in downloadArray {
            if download.taskImageView?.md5Key == imageView.md5Key {
                return true
            }
        }
        return false
    }
    
    func searchCacheImage(imageView : UIImageView) -> Bool {
        if let image = self.cache.object(forKey: (imageView.urlKey + "\(imageView.scaleType)").md5() as NSString) {
            setViewImage(view: imageView, image: image)
            return true
        }
        return false
    }
}
