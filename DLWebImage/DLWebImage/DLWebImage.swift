import UIKit

enum DLImageScaleType : Int {
    case scaleOriginal   = 0  //  原图
    case scaleFit             //  缩放
    case scaleFill            //  填充
    case scaleAdaption        //  自适应（缩放为imageView大小）
}

class DLWebImage: NSObject {
    
    private(set) var view : UIView?
    
    private(set) var url : String = ""
    
    private(set) var scaleType : DLImageScaleType = .scaleOriginal
    
    private(set) var failImage : UIImage?
    
    private(set) var placeholderImage : UIImage?
    
    private(set) var size : CGSize = .zero
    
    private(set) var md5Key : String = ""
    
    private(set) var cacheKey : String = ""
    
    private(set) var state : UIControl.State = .normal
        
    private(set) var spinner : UIActivityIndicatorView?
    
    private(set) var progressBlock : ((_ progress : Float) ->())?
    
    private(set) var completionBlock : ((_ image : UIImage?) ->())?
    
    private(set) var failBlock : (() ->())?
        
    func resume() {
        self.md5Key = self.url.md5()
        self.cacheKey = (self.url + "\(self.scaleType)").md5()
        self.view?.cacheKey = (self.url + "\(self.scaleType)").md5()
        self.size = self.view?.frame.size ?? .zero
        if self.placeholderImage == nil {
            spinner = UIActivityIndicatorView.init(style: .large)
            spinner?.startAnimating()
            spinner?.center = CGPoint.init(x: self.size.width * 0.5, y: self.size.height * 0.5)
            spinner?.color = .gray
            self.view?.addSubview(spinner!)
        }
        DLDownloadManage.shareInstance().addTask(task: self)
    }
    
    func url(_ url : String) -> DLWebImage {
        self.url = url
        return self
    }
    
    func scaleType(_ scaleType : DLImageScaleType) -> DLWebImage {
        self.scaleType = scaleType
        return self
    }
    
    func failImage(_ failImage : UIImage?) -> DLWebImage {
        self.failImage = failImage
        return self
    }
    
    func placeholderImage(_ placeholderImage : UIImage?) -> DLWebImage {
        self.placeholderImage = placeholderImage
        return self
    }
    
    func state(_ state : UIControl.State) -> DLWebImage {
        self.state = state
        return self
    }
    
    func progressBlock(_ progressBlock : ((_ progress : Float) ->())?) -> DLWebImage {
        self.progressBlock = progressBlock
        return self
    }
    
    func completionBlock(_ completionBlock : ((_ image : UIImage?) ->())?) -> DLWebImage {
        self.completionBlock = completionBlock
        return self
    }
    
    func failBlock(_ failBlock : (() ->())?) -> DLWebImage {
        self.failBlock = failBlock
        return self
    }
    
    class func webImage(_ view : UIView?) -> DLWebImage {
        let task = DLWebImage.init()
        task.view = view
        return task
    }
    
}
