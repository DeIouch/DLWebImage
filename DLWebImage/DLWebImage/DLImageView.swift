//
//  DLImageView.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import UIKit

private var url_key : Void?

private var url_md5_key : Void?

private var scale_type_key : Void?

private var fail_image_key : Void?

enum DLImageScaleType : Int {
    case scaleToFill   = 1  //  原图
    case scaleFit           //  缩放
    case scaleFill          //  填充
    case scaleAdaption      //  自适应（缩放为imageView大小）
}

extension UIImageView {
    
    var urlKey : String {
        get {
            return objc_getAssociatedObject(self, &url_key) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &url_key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    var md5Key : String {
        get {
            return objc_getAssociatedObject(self, &url_md5_key) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &url_md5_key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    var scaleType : DLImageScaleType {
        get {
            return objc_getAssociatedObject(self, &scale_type_key) as? DLImageScaleType ?? .scaleToFill
        }
        set {
            objc_setAssociatedObject(self, &scale_type_key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var failImage : UIImage? {
        get {
            return objc_getAssociatedObject(self, &fail_image_key) as? UIImage
        }
        set {
            objc_setAssociatedObject(self, &fail_image_key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    func dl_imageView(url : String) {
        self.urlKey = url
        self.md5Key = url.md5()
        DLDownloadManage.shareInstance().addTask(urlStr: url, imageView: self)
    }
    
    func dl_imageView(url : String, placeholderImage : UIImage?) {
        self.urlKey = url
        self.image = placeholderImage
        self.md5Key = url.md5()
        DLDownloadManage.shareInstance().addTask(urlStr: url, imageView: self)
    }
    
    func dl_imageView(url : String, placeholderImage : UIImage?, scaleType : DLImageScaleType) {
        self.urlKey = url
        self.image = placeholderImage
        self.scaleType = scaleType
        self.md5Key = url.md5()
        DLDownloadManage.shareInstance().addTask(urlStr: url, imageView: self)
    }
    
    func dl_imageView(url : String, placeholderImage : UIImage?, failImage : UIImage?, scaleType : DLImageScaleType) {
        self.urlKey = url
        self.image = placeholderImage
        self.scaleType = scaleType
        self.failImage = failImage
        self.md5Key = url.md5()
        DLDownloadManage.shareInstance().addTask(urlStr: url, imageView: self)
    }

}