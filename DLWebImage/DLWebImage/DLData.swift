//
//  DLData.swift
//  DLWebImage
//
//  Created by qing on 2021/8/16.
//

import UIKit

enum DLFileType : Int {
    case Unknown, JPG, BMP, PNG, SWF, EXE, RAR, ZIP, XML, HTML, ASPX, CS, JS, TXT, SQL, GIF
}

extension NSData {
    func getFileType() -> DLFileType {
        var type : DLFileType = .Unknown
        var char1 : Int = 0
        var char2 : Int = 0
        getBytes(&char1, range: NSRange.init(location: 0, length: 1))
        getBytes(&char2, range: NSRange.init(location: 1, length: 1))
        switch "\(char1)"+"\(char2)" {
        case "255216":
            type = .JPG
        case "6677":
            type = .BMP
        case "13780":
            type = .PNG
        case "6787":
            type = .SWF
        case "7790":
            type = .EXE
        case "8297":
            type = .RAR
        case "8075":
            type = .ZIP
        case "6063":
            type = .XML
        case "6033":
            type = .HTML
        case "239187":
            type = .ASPX
        case "117115":
            type = .CS
        case "119105":
            type = .JS
        case "102100":
            type = .TXT
        case "255254":
            type = .SQL
        case "7173":
            type = .GIF
        default:
            type = .Unknown
        }
        return type
    }
    
    func getImages() -> UIImage? {
        let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber(value: true), kCGImageSourceTypeIdentifierHint as String: "DLGIF"]
        guard let imageSource = CGImageSourceCreateWithData(self, options) else {
            return nil
        }
        let frameCount = CGImageSourceGetCount(imageSource)
        var images = [UIImage]()
        var gifDuration = 0.0
        for i in 0 ..< frameCount {
            guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, options) else {
                return nil
            }
            if frameCount == 1 {
                gifDuration = Double.infinity
            } else{
                guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) , let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                      let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else
                {
                    return nil
                }
                gifDuration += frameDuration.doubleValue
                let image = UIImage(cgImage: imageRef , scale: UIScreen.main.scale , orientation: UIImage.Orientation.up)
                images.append(image)
            }
        }
        return UIImage.animatedImage(with: images, duration: gifDuration)
    }
    
}
