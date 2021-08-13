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

class DLDownloader: NSObject, URLSessionDownloadDelegate {

    var filePath : String = ""
        
    var task : URLSessionTask!
    
    var progressBlock : ((_ progress : Float) ->())?
    
    var completionBlock : ((_ image : UIImage) ->())?
    
    var state : DLDownloadState = .ready
        
    var index = 0
        
    var key : String = ""
    
    var imageViewSize : CGSize = .zero
    
    var imageView : UIImageView?
        
}

extension DLDownloader {
    func download(urlStr : String, filePath : String, imageViewSize : CGSize, imageView : UIImageView, progress: ((_ progress : Float) ->())?, completion: ((_ image : UIImage) ->())?) {
        self.filePath = filePath
        self.state = .ready
        self.imageViewSize = imageViewSize
        self.imageView = imageView
        let session = URLSession.init(configuration:URLSessionConfiguration.default , delegate: self, delegateQueue: OperationQueue.init())
        self.task = session.downloadTask(with: URL.init(string: urlStr)!)
        self.progressBlock = progress
        self.completionBlock = completion
        if DLDownloadManage.shareInstance().fileManager.fileExists(atPath: filePath) {
            self.state = .decode
            DispatchQueue.global().async {
                if let image = UIImage.init(contentsOfFile: self.filePath) {
                    self.decodedImage(image: image) { (decodedImage) in
                        self.state = .finish
                        self.completionBlock?(decodedImage)
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
    
    func decodedImage(image : UIImage, completion: ((_ image : UIImage) ->())?) {
        autoreleasepool {
            let cgImage = image.cgImage!
            var width : CGFloat = CGFloat(cgImage.width)
            var height : CGFloat = CGFloat(cgImage.height)
            if imageViewSize.width > 0 && imageViewSize.height > 0 {
                switch imageView?.scaleType {
                    case .scaleFill:
                        if imageViewSize.width < CGFloat(width) || imageViewSize.height < CGFloat(height) {
                            let scale = CGFloat(width) / imageViewSize.width < CGFloat(height) / imageViewSize.height ? CGFloat(width) / imageViewSize.width : CGFloat(height) / imageViewSize.height
                            width = width / scale
                            height = height / scale
                        }
                        break
                    
                    case .scaleFit:
                        if imageViewSize.width < CGFloat(width) || imageViewSize.height < CGFloat(height) {
                            let scale = CGFloat(width) / imageViewSize.width > CGFloat(height) / imageViewSize.height ? CGFloat(width) / imageViewSize.width : CGFloat(height) / imageViewSize.height
                            width = width / scale
                            height = height / scale
                        }
                        break
                    
                    case .scaleAdaption:
                        width = imageViewSize.width
                        height = imageViewSize.height
                        break
                default:
                    break
                }
            }
            let context : CGContext? = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: (!(cgImage.alphaInfo == .none || cgImage.alphaInfo == .noneSkipFirst || cgImage.alphaInfo == .noneSkipLast)) ? 2 : 6)
            context?.concatenate(CGAffineTransform.identity);
            context?.draw(cgImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
            imageView = nil
            completion?(UIImage.init(cgImage: (context?.makeImage())!, scale: image.scale, orientation: image.imageOrientation))
        }
    }
        
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        autoreleasepool {
            var data : Data?
            do {
                try data = Data.init(contentsOf: location)
            } catch  {
                
            }
            if DLDownloadManage.shareInstance().fileManager.fileExists(atPath: filePath) == false {
                do {
                    try DLDownloadManage.shareInstance().fileManager.moveItem(at: location, to: URL.init(fileURLWithPath: filePath))
                } catch {
        
                }
            }
            if let image = UIImage.init(data: data ?? Data.init()) {
                self.decodedImage(image: image) { (decodedImage) in
                    self.state = .finish
                    self.completionBlock?(decodedImage)
                }
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        self.progressBlock?(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil && imageView?.failImage != nil {
            self.completionBlock?(imageView!.failImage!)
        }
    }
    
}


//        var char1 : Int = 0
//        var char2 : Int = 0
//        data?.getBytes(&char1, range: NSRange.init(location: 0, length: 1))
//        data?.getBytes(&char2, range: NSRange.init(location: 1, length: 1))
//        var type = ""
//        switch "\(char1)"+"\(char2)" {
//        case "255216":
//            type = ".jpg"
//        case "6677":
//            type = ".bmp"
//        case "13780":
//            type = ".png"
//        case "6787":
//            type = ".swf"
//        case "7790":
//            type = ".exe"
//        case "8297":
//            type = ".rar"
//        case "8075":
//            type = ".zip"
//        case "55122":
//            type = ".7z"
//        case "6063":
//            type = ".xml"
//        case "6033":
//            type = ".html"
//        case "239187":
//            type = ".aspx"
//        case "117115":
//            type = ".cs"
//        case "119105":
//            type = ".js"
//        case "102100":
//            type = ".txt"
//        case "255254":
//            type = ".sql"
//        default:
//            type = ""
//        }
