import UIKit

enum DLDownloadState : Int {
    case ready              =   1
    case downloading
    case decode
    case finish
    case suspend
}

class DLDownloader: NSObject, URLSessionDataDelegate, URLSessionDownloadDelegate {
            
    var task : URLSessionTask!
            
    var state : DLDownloadState = .ready
        
    var index = 0
                
    var progressBlock : ((_ progress : Float) ->())?
    
    var completionBlock : ((_ image : UIImage?) ->())?
    
    var failBlock : (() ->())?
            
    var taskViewSize : CGSize = .zero
    
    var urlStr : String = ""
    
    var scaleType : DLImageScaleType = .scaleOriginal
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 10
        let sess = URLSession.init(configuration:configuration , delegate: self, delegateQueue: OperationQueue.init())
        return sess
    }()
    
}

extension DLDownloader {
    func download(url : String, scaleType : DLImageScaleType, size : CGSize, progressBlock : ((_ progress : Float) ->())?, completionBlock : ((_ image : UIImage?) ->())?, failBlock : (() ->())?) {
        self.state = .ready
        self.taskViewSize = size
        self.progressBlock = progressBlock
        self.completionBlock = completionBlock
        self.urlStr = url
        self.failBlock = failBlock
        self.scaleType = scaleType
        self.task = session.downloadTask(with: URL.init(string: url)!)
        if DLImageCache.shareInstance().fileExists(path: url) {
            self.state = .decode
            DLImageCache.shareInstance().saveFileToCache(url: url, scaleType: scaleType, size: size) { (image) in
                self.state = .finish
                completionBlock?(image)
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
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if DLImageCache.shareInstance().fileExists(path: urlStr) == false {
            do {
                try FileManager.default.moveItem(at: location, to: URL.init(fileURLWithPath: DLImageCache.shareInstance().getFilePath(url: urlStr)))
            } catch {

            }
        }
        DLImageCache.shareInstance().saveFileToCache(url: self.urlStr, scaleType: self.scaleType, size: self.taskViewSize) { (decodedImage) in
            self.state = .finish
            self.completionBlock?(decodedImage)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        self.progressBlock?(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            self.failBlock?()
        }
    }
}
