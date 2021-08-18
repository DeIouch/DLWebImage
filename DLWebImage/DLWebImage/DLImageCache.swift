//
//  DLCache.swift
//  DLWebImage
//
//  Created by qing on 2021/8/18.
//

import UIKit

class DLImageCache: NSObject {
    
    private let filePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/dl_webImageCache/"
    
    private static let dl_imageCache = DLImageCache.init()
    
    private let fileManager = FileManager.init()
        
    private var memoryCache : Dictionary = Dictionary<String, UIImage>.init()
    
    public static func shareInstance() -> DLImageCache {
        return dl_imageCache
    }
    
    private override init() {
        super.init()
        fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)
    }
    
    func setObject(file : URL,key : String, size : CGSize, scaleType : DLImageScaleType, completionBlock : ((_ image : UIImage?) ->())?) {
        autoreleasepool {
            if key.count == 0 {
                completionBlock?(nil)
                return
            }
            DispatchQueue.global().async {
                if let data = NSData.init(contentsOf: file) {
                    switch data.getFileType() {
                    case .GIF:
                        if let imageDecode = data.getImages() {
                            self.memoryCache[(key + "\(scaleType)").md5()] = imageDecode
                            completionBlock?(imageDecode)
                        }
                        
                    case .JPG, .PNG:
                        if let dataImage = UIImage.init(data: data as Data) {
                            self.memoryCache[(key + "\(scaleType)").md5()] = dataImage.decodedImage(size: size, scaleType: scaleType)
                            completionBlock?(dataImage)
                        }
                        break
                        
                    default:
                        break
                    }
                }
                do {
                    try self.fileManager.moveItem(at: file, to: URL.init(string: self.filePath + key)!)
                } catch {
                    
                }
            }
        }
    }
    
    func fileExists(key : String) -> Bool {
        return fileManager.fileExists(atPath: filePath + key)
    }
    
    func object(key: String, size : CGSize, scaleType : DLImageScaleType, completionBlock : ((_ image : UIImage?) ->())?) {
        autoreleasepool {
            var image : UIImage?
            if key.count == 0 {
                completionBlock?(image)
                return
            }
            if let imageCache = memoryCache[(key + "\(scaleType)").md5()] {
                image = imageCache
                completionBlock?(image)
                return
            }
            if fileManager.fileExists(atPath: filePath + key) {
                DispatchQueue.global().async {
                    if let data = NSData.init(contentsOfFile: self.filePath + key) {
                        switch data.getFileType() {
                        case .GIF:
                            if let imageDecode = data.getImages() {
                                image = imageDecode
                                self.memoryCache[(key + "\(scaleType)").md5()] = image
                            }
                            
                        case .JPG, .PNG:
                            if let dataImage = UIImage.init(data: data as Data) {
                                image = dataImage.decodedImage(size: size, scaleType: scaleType)
                                self.memoryCache[(key + "\(scaleType)").md5()] = image
                            }
                            break
                            
                        default:
                            break
                        }
                        completionBlock?(image)
                        return
                    }
                }
            }
        }
    }
    
}
