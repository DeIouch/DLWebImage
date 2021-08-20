import UIKit

enum DLImageScaleType : Int {
    case scaleOriginal   = 0  //  原图
    case scaleFit             //  缩放
    case scaleFill            //  填充
    case scaleAdaption        //  自适应（缩放为imageView大小）
}

class DLWebImageView: NSObject {
    
    private(set) var view : UIView?
    
    private(set) var url : String = ""
    
    private(set) var scaleType : DLImageScaleType = .scaleOriginal
    
    private(set) var failImage : UIImage?
    
    private(set) var size : CGSize = .zero
    
    private(set) var md5Key : String = ""
    
    private(set) var cacheKey : String = ""
    
    private(set) var state : UIControl.State = .normal
    
    private(set) var showLoading : Bool = false
    
    private(set) var spinner : UIActivityIndicatorView?
    
    private(set) var progressBlock : ((_ progress : Float) ->())?
    
    private(set) var completionBlock : ((_ image : UIImage?) ->())?
    
    private(set) var failBlock : (() ->())?
    
    func resume() {
        self.md5Key = self.url.md5()
        self.cacheKey = (self.url + "\(self.scaleType)").md5()
        self.size = self.view?.frame.size ?? .zero
        if showLoading == true {
            spinner = UIActivityIndicatorView.init(style: .large)
            spinner?.startAnimating()
            spinner?.center = CGPoint.init(x: self.size.width * 0.5, y: self.size.height * 0.5)
            spinner?.color = .gray
            self.view?.addSubview(spinner!)
        }
        DLDownloadManage.shareInstance().addTask(task: self)
    }
    
    func url(url : String) -> DLWebImageView {
        self.url = url
        return self
    }
    
    func showLoading(showLoading : Bool) -> DLWebImageView {
        self.showLoading = showLoading
        return self
    }
    
    func scaleType(scaleType : DLImageScaleType) -> DLWebImageView {
        self.scaleType = scaleType
        return self
    }
    
    func failImage(failImage : UIImage?) -> DLWebImageView {
        self.failImage = failImage
        return self
    }
    
    func state(state : UIControl.State) -> DLWebImageView {
        self.state = state
        return self
    }
    
    func progressBlock(progressBlock : ((_ progress : Float) ->())?) -> DLWebImageView {
        self.progressBlock = progressBlock
        return self
    }
    
    func completionBlock(completionBlock : ((_ image : UIImage?) ->())?) -> DLWebImageView {
        self.completionBlock = completionBlock
        return self
    }
    
    func failBlock(failBlock : (() ->())?) -> DLWebImageView {
        self.failBlock = failBlock
        return self
    }
    
    class func setWebImage(view : UIView) -> DLWebImageView {
        let task = DLWebImageView.init()
        task.view = view
        return task
    }
    
}
