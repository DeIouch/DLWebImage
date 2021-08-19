//
//  DLDownloadTask.swift
//  DLWebImage
//
//  Created by qing on 2021/8/19.
//

import UIKit

class DLDownloadTask: NSObject {
    
    var taskView : UIView?
    
    var url : String = ""
    
    var scaleType : DLImageScaleType = .scaleOriginal
    
    var failImage : UIImage?
    
    var taskSize : CGSize = .zero
    
    var md5Key : String = ""
    
    var cacheKey : String = ""
    
    var state : UIControl.State = .normal
    
    func resume() {
        self.md5Key = self.url.md5()
        self.cacheKey = (self.url + "\(self.scaleType)").md5()
        DLDownloadManage.shareInstance().addTask(task: self)
    }
    
    func url(url : String) -> DLDownloadTask {
        self.url = url
        return self
    }
    
    func scaleType(scaleType : DLImageScaleType) -> DLDownloadTask {
        self.scaleType = scaleType
        return self
    }
    
    func failImage(failImage : UIImage?) -> DLDownloadTask {
        self.failImage = failImage
        return self
    }
    
    func state(state : UIControl.State) -> DLDownloadTask {
        self.state = state
        return self
    }
    
    
    
}
