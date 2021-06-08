//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/5/24.
//

import UIKit

public extension UIColor {
    
    convenience init(Hex: UInt32) {
        
        let red : CGFloat = CGFloat((Hex & 0xff0000) >> 16)
        let green : CGFloat = CGFloat((Hex & 0xff00) >> 8)
        let blue : CGFloat = CGFloat(Hex & 0xff)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
    convenience init(HexStr: String) {
        
        var hex: Int = 0
        Scanner(string: HexStr).scanInt(&hex)
        self.init(Hex: UInt32(hex))
    }
    
    /// 随机颜色
    /// - Returns: 颜色
    static func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0,
                            green: CGFloat(arc4random_uniform(256)) / 255.0,
                            blue: CGFloat(arc4random_uniform(256)) / 255.0,
                            alpha: 1)
        return color
    }
    
    /// RGB 颜色
    /// - Parameters:
    ///   - red: 红 0~255
    ///   - green: 绿 0~255
    ///   - blue: 蓝 0~255
    ///   - alpha: 透明度 0~1
    /// - Returns: 颜色
    static func RGBColor(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) -> UIColor {
        let color = UIColor(red: CGFloat(red) / 255.0,
                            green: CGFloat(green) / 255.0,
                            blue: CGFloat(blue) / 255.0,
                            alpha: alpha)
        return color
    }
}

