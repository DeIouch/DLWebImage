//
//  DLMemoryCache.swift
//  DLWebImage
//
//  Created by qing on 2021/8/18.
//

import UIKit

class DLImageCache: NSObject {
    
    private static let dl_memoryCache = DLImageCache.init()
        
    private var cache : NSCache = NSCache<NSString, UIImage>.init()
        
    private let filePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/"
    
    public static func shareInstance() -> DLImageCache {
        return dl_memoryCache
    }
    
    func fileExists(path : String) -> Bool {
        return FileManager.default.fileExists(atPath: filePath + path.md5())
    }
    
    func saveFileToCache(url : String, scaleType : DLImageScaleType, size : CGSize, completionBlock : ((_ image : UIImage?) ->())?) {
        if let image = object(forKey: (url + "\(scaleType)").md5()) {
            completionBlock?(image)
            return
        }
        DispatchQueue.global().async {
            let data : NSData? = NSData.init(contentsOfFile: self.getFilePath(url: url))
            let imageType = data?.getImageType()
            if imageType == .gif {
                let image = data?.getImages()
                if let dataImage = image {
                    self.setObject(dataImage, forKey: (url + "\(scaleType)").md5())
                }
                completionBlock?(image)
            }else if imageType != .unknown {
                if let image = UIImage.init(contentsOfFile: self.getFilePath(url: url)) {
                    image.decodedImage(size: size, scaleType: scaleType) { (decodedImage) in
                        if let dataImage = decodedImage {
                            self.setObject(dataImage, forKey: (url + "\(scaleType)").md5())
                        }
                        completionBlock?(decodedImage)
                    }
                }
            }else {
                completionBlock?(nil)
            }
        }
    }
    
    func getFilePath(url : String) -> String {
        return filePath + url.md5()
    }
    
    func object(forKey key: String) -> UIImage?{
        if key.count == 0 {
            return nil
        }
        return cache.object(forKey: key as NSString)
    }

    func setObject(_ image: UIImage, forKey key: String) {
        if key.count == 0 {
            return
        }
        objc_sync_enter(cache)
        cache.setObject(image, forKey: key as NSString)
        objc_sync_exit(cache)
    }
    
}
