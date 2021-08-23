import UIKit

private var url_key : Void?

extension UIView {

    var cacheKey : String {
        get {
            return objc_getAssociatedObject(self, &url_key) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &url_key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}
