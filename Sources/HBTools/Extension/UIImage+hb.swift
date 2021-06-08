//
//  UIImage+hb.swift
//  HBToolDemo
//
//  Created by 沈红榜 on 2021/6/7.
//

import UIKit

public extension UIImage {
    
    /// 生成二维码
    /// - Parameters:
    ///   - text: 要生成的文案
    ///   - width: 二维码图片宽度
    ///   - correctionLevel: 容错率
    ///   - foregroundColor: 二维码颜色
    ///   - backgroundColor: 二维码背景色
    /// - Returns: 图片
    static func qrImage(_ text: String, width: Int = 100, correctionLevel: QRCorrectionLevel = .M, foregroundColor: UIColor = .black, backgroundColor: UIColor = .white) -> UIImage? {
        
        guard let data = text.data(using: .utf8) else { return nil }

        guard let filter = CIFilter(name: .CIQRCodeGenerator) else { return nil }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue(correctionLevel.rawValue, forKey: "inputCorrectionLevel")
        
        guard let qrimg = filter.outputImage else { return nil }
        
        let imgSize = qrimg.extent.size
        let transform = CGAffineTransform(scaleX: CGFloat(width) / imgSize.width, y: CGFloat(width) / max(imgSize.height, 1))
        
        let result = qrimg.transformed(by: transform)
        
        let colorFilter = CIFilter(name: .CIFalseColor, param: ["inputImage": result,
                                                                "inputColor0" : CIColor(color: foregroundColor),
                                                                "inputColor1" : CIColor(color: backgroundColor)])
        
        
        guard let tmpImg = colorFilter?.outputImage else { return UIImage(ciImage: result) }
        return UIImage(ciImage: tmpImg)
    }
    
    /// 图片内二维码识别到的文案
    /// - Returns: 字符串数组
    func qrStrings() -> [String]? {
        
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh]) else { return nil }
        
        guard let cgImage = self.cgImage else { return nil }
        
        let img = CIImage(cgImage: cgImage)
        
        let features = detector.features(in: img)
        
        var messages: [String] = []
        
        for item in features {
            
            let feature = item as! CIQRCodeFeature
            
            if let msg = feature.messageString {
                messages.append(msg)
            }
        }
        
        return messages.count > 0 ? messages : nil
    }
    
    
}

public extension UIImage {
    /// 重绘图片
    /// - Parameter size: 目标尺寸
    /// - Returns: 图片
    func resize(_ size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        draw(in: .init(origin: .zero, size: size))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? self
    }
    
    convenience init?(color: UIColor, size: CGSize = .init(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return  nil }

        context.setFillColor(color.cgColor)
        context.fill(.init(origin: .zero, size: size))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = img?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

