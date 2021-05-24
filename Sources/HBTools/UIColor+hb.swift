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
        
        var hex: UInt32 = 0
        Scanner(string: HexStr).scanHexInt32(&hex)
        self.init(Hex: hex)
    }
}

