//
//  DLDownloader.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import UIKit

enum DLDownloadState : Int {
    case ready              =   1
    case downloading
    case decode
    case finish
    case suspend
}

class DLDownloader: NSObject, URLSessionDataDelegate, URLSessionDownloadDelegate {
    
    var filePath : String = ""
        
    var task : URLSessionTask!
            
    var state : DLDownloadState = .ready
        
    var index = 0
                
    var progressBlock : ((_ progress : CGFloat) ->())?
    
    var completionBlock : ((_ image : UIImage?) ->())?
    
    var taskImageView : UIImageView?
    
    var taskViewSize : CGSize = .zero
    
}

extension DLDownloader {
    func download(imageView : UIImageView, size : CGSize, filePath : String, progressBlock : ((_ progress : CGFloat) ->())?, completionBlock : ((_ image : UIImage?) ->())?) {
        self.filePath = filePath
        self.state = .ready
        self.taskViewSize = size
        self.progressBlock = progressBlock
        self.completionBlock = completionBlock
        self.taskImageView = imageView
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.allowsCellularAccess = true
        let session = URLSession.init(configuration:configuration , delegate: self, delegateQueue: OperationQueue.init())
        self.task = session.downloadTask(with: URL.init(string: imageView.urlKey)!)
        if DLDownloadManage.shareInstance().fileManager.fileExists(atPath: filePath) {
            self.state = .decode
            DispatchQueue.global().async {
                let data : NSData? = NSData.init(contentsOfFile: self.filePath)
                if data?.getFileType() == .GIF {
                    let image = data?.getImages()
                    if let dataImage = image {
                        DLMemoryCache.shareInstance().setObject(dataImage, forKey: imageView.md5Key + "\(imageView.scaleType)")
                    }
                    completionBlock?(data?.getImages())
                }else {
                    if let image = UIImage.init(contentsOfFile: self.filePath) {
                        if let imageView = self.taskImageView {
                            image.decodedImage(size: self.taskViewSize, scaleType: imageView.scaleType) { (decodedImage) in
                                self.state = .finish
                                if let dataImage = decodedImage {
                                    DLMemoryCache.shareInstance().setObject(dataImage, forKey: imageView.md5Key + "\(imageView.scaleType)")
                                }
                                self.completionBlock?(decodedImage)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func suspendDown() {
        self.task.suspend()
        self.state = .suspend
    }
    
    func resumeDown() {
        if self.state != .finish && self.state != .decode {
            self.task.resume()
            self.state = .downloading
        }
    }
    
//    func decodedImage(image : UIImage, completion: ((_ image : UIImage?) ->())?) {
//        autoreleasepool {
//            let cgImage = image.cgImage!
//            var width : CGFloat = CGFloat(cgImage.width)
//            var height : CGFloat = CGFloat(cgImage.height)
//
//            if self.taskViewSize.width > 0 && self.taskViewSize.height > 0 {
//                switch self.taskImageView?.scaleType {
//                        case .scaleFill:
//                            if self.taskViewSize.width < CGFloat(width) || self.taskViewSize.height < CGFloat(height) {
//                                let scale = CGFloat(width) / self.taskViewSize.width < CGFloat(height) / self.taskViewSize.height ? CGFloat(width) / self.taskViewSize.width : CGFloat(height) / self.taskViewSize.height
//                                width = width / scale
//                                height = height / scale
//                            }
//                            break
//
//                        case .scaleFit:
//                            if self.taskViewSize.width < CGFloat(width) || self.taskViewSize.height < CGFloat(height) {
//                                let scale = CGFloat(width) / self.taskViewSize.width > CGFloat(height) / self.taskViewSize.height ? CGFloat(width) / self.taskViewSize.width : CGFloat(height) / self.taskViewSize.height
//                                width = width / scale
//                                height = height / scale
//                            }
//                            break
//
//                        case .scaleAdaption:
//                            width = self.taskViewSize.width
//                            height = self.taskViewSize.height
//                            break
//                    default:
//                        break
//                    }
//                }
//            let context : CGContext? = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: (!(cgImage.alphaInfo == .none || cgImage.alphaInfo == .noneSkipFirst || cgImage.alphaInfo == .noneSkipLast)) ? 2 : 6)
//            context?.concatenate(CGAffineTransform.identity);
//            context?.draw(cgImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
//            completion?(UIImage.init(cgImage: (context?.makeImage())!, scale: image.scale, orientation: image.imageOrientation))
//        }
//    }
        
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        autoreleasepool {
            let data : NSData? = NSData.init(contentsOf: location)
            if DLDownloadManage.shareInstance().fileManager.fileExists(atPath: filePath) == false {
                do {
                    try DLDownloadManage.shareInstance().fileManager.moveItem(at: location, to: URL.init(fileURLWithPath: filePath))
                } catch {
        
                }
            }
            if data?.getFileType() == .GIF {
                let image = data?.getImages()
                if let dataImage = image {
                    DLMemoryCache.shareInstance().setObject(dataImage, forKey: self.taskImageView?.md5Key ?? "" + "\(self.taskImageView?.scaleType ?? .scaleOriginal)")
                }
                self.completionBlock?(data?.getImages())
            }else {
                if let image = UIImage.init(contentsOfFile: self.filePath) {
                    if let imageView = self.taskImageView {
                        image.decodedImage(size: self.taskViewSize, scaleType: imageView.scaleType) { (decodedImage) in
                            if let dataImage = decodedImage {
                                DLMemoryCache.shareInstance().setObject(dataImage, forKey: self.taskImageView?.md5Key ?? "" + "\(self.taskImageView?.scaleType ?? .scaleOriginal)")
                            }
                            self.state = .finish
                            self.completionBlock?(decodedImage)
                        }
                    }
                }
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        self.progressBlock?(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil && self.taskImageView?.failImage != nil {
            self.completionBlock?(self.taskImageView?.failImage)
        }
    }
    
}
