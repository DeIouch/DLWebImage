import UIKit

extension UIImage {
    func decodedImage(size : CGSize, scaleType : DLImageScaleType, completionBlock : ((_ image : UIImage?) ->())?){
        autoreleasepool {
            let cgImage = self.cgImage!
            var width : CGFloat = CGFloat(cgImage.width)
            var height : CGFloat = CGFloat(cgImage.height)
            if size.width > 0 && size.height > 0 {
                switch scaleType {
                    case .scaleFill:
                        if size.width < CGFloat(width) || size.height < CGFloat(height) {
                            let scale = CGFloat(width) / size.width < CGFloat(height) / size.height ? CGFloat(width) / size.width : CGFloat(height) / size.height
                            width = width / scale
                            height = height / scale
                        }
                        break
                    
                    case .scaleFit:
                        if size.width < CGFloat(width) || size.height < CGFloat(height) {
                            let scale = CGFloat(width) / size.width > CGFloat(height) / size.height ? CGFloat(width) / size.width : CGFloat(height) / size.height
                            width = width / scale
                            height = height / scale
                        }
                        break
                    
                    case .scaleAdaption:
                        width = size.width
                        height = size.height
                        break
                default:
                    break
                }
            }
            let context : CGContext? = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: (!(cgImage.alphaInfo == .none || cgImage.alphaInfo == .noneSkipFirst || cgImage.alphaInfo == .noneSkipLast)) ? 2 : 6)
            context?.concatenate(CGAffineTransform.identity);
            context?.draw(cgImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
            completionBlock?(UIImage.init(cgImage: (context?.makeImage())!, scale: self.scale, orientation: self.imageOrientation))
        }
    }
}
