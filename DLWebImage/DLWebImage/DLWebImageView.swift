//
//  DLImageView.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import UIKit

enum DLImageScaleType : Int {
    case scaleOriginal   = 1  //  原图
    case scaleFit           //  缩放
    case scaleFill          //  填充
    case scaleAdaption      //  自适应（缩放为imageView大小）
}

private var dlWebImage_Task_key : Void?

extension UIView {
    
    var dl_webImage : DLDownloadTask {
        get {
            var task = objc_getAssociatedObject(self, &dlWebImage_Task_key) as? DLDownloadTask
            if task == nil {
                task = DLDownloadTask.init()
                task?.taskView = self
                task?.taskSize = self.frame.size
                objc_setAssociatedObject(self, &dlWebImage_Task_key, task, .OBJC_ASSOCIATION_RETAIN)
            }
            return task!
        }set{
            objc_setAssociatedObject(self, &dlWebImage_Task_key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

}
