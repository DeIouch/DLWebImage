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
    
    func taskRun(downloader : DLDownloader?) {
        let imageView = taskArray.first!
        guard searchCacheImage(imageView: imageView) == false else {
            taskArray.removeFirst()
            if self.taskArray.count > 0 {
                self.taskRun(downloader: nil)
            }
            return
        }
        guard searchRepetitiveDownload(imageV: imageView) == false else {
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
        var dlDownload : DLDownloader? = downloader
        if dlDownload == nil {
            dlDownload = searchFreeDownload()
        }
        if let download = dlDownload {
            taskArray.removeFirst()
            download.key = imageView.md5Key
            download.download(urlStr: imageView.urlKey, filePath: filePath + imageView.md5Key, imageViewSize: imageView.frame.size, imageView: imageView, progress: nil, completion: { [weak self](image) in
                download.state = .finish
                download.key = ""
                self?.downloadArray[download.index] = download
                self?.cache.setObject(image, forKey: imageView.md5Key as NSString)
                DispatchQueue.main.async {[weak self] in
                    if self?.taskArray.count ?? 0 > 0 {
                        self?.taskRun(downloader: download)
                    }
                    imageView.image = image
                }
            })
            download.resumeDown()
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
    
    func addTask(urlStr : String, imageView : UIImageView) {
        taskArray.append(imageView)
        taskRun(downloader: nil)
    }
    
    func searchRepetitiveDownload(imageV : UIImageView) -> Bool {
        for download in downloadArray {
            if download.key == imageV.md5Key {
                return true
            }
        }
        return false
    }
    
    func searchCacheImage(imageView : UIImageView) -> Bool {
        if let image = self.cache.object(forKey: imageView.md5Key as NSString) {
            imageView.image = image
            return true
        }
        return false
    }
}
