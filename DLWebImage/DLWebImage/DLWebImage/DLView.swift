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
    
    func displayedInScreen() -> Bool {
        if self.superview == nil || self.isHidden == true || self.alpha == 0.01 {
            return false
        }
        var rect = self.convert(self.frame, to: UIScreen.main as! UICoordinateSpace)
        if self is UIScrollView {
            if let scorll : UIScrollView = self as? UIScrollView {
                rect.origin.x = rect.origin.x + scorll.contentOffset.x
                rect.origin.y = rect.origin.y + scorll.contentOffset.y
            }
        }
        return rect.intersects(UIScreen.main.bounds)
    }
    
}
