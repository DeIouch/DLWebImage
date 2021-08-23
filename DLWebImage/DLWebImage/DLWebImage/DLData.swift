import UIKit

enum DLImageType {
        case unknown
        case jpeg
        case tiff
        case bmp
        case ico
        case icns
        case gif
        case png
        case webp
    }

extension NSData {

    func getImageType() -> DLImageType {
        var char : UInt8 = 0
        getBytes(&char, range: NSRange.init(location: 0, length: 1))
        switch char {
        case 0xFF:
            return .jpeg
        case 0x4D, 0x49:
            return .tiff
        case 0x00:
            return .ico
        case 0x69:
            return .icns
        case 0x47:
            return .gif
        case 0x89:
            return .png
        case 0x42:
            return .bmp
        default:
            return .unknown
        }
    }
    
    func getImages() -> UIImage? {
        autoreleasepool {
            let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber(value: true), kCGImageSourceTypeIdentifierHint as String: "DLGIF"]
            guard let imageSource = CGImageSourceCreateWithData(self, options) else {
                return nil
            }
            let frameCount = CGImageSourceGetCount(imageSource)
            if frameCount == 0 {
                return nil
            }
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
                    let context : CGContext? = CGContext.init(data: nil, width: imageRef.width, height: imageRef.height, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: (!(imageRef.alphaInfo == .none || imageRef.alphaInfo == .noneSkipFirst || imageRef.alphaInfo == .noneSkipLast)) ? 2 : 6)
                    context?.concatenate(CGAffineTransform.identity);
                    context?.draw(imageRef, in: CGRect.init(x: 0, y: 0, width: imageRef.width, height: imageRef.height))
                    images.append(UIImage.init(cgImage: (context?.makeImage())!))
                }
            }
            return UIImage.animatedImage(with: images, duration: gifDuration)
        }
    }
    
}
