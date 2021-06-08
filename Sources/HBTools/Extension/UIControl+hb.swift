//
//  UIControl+hb.swift
//  
//
//  Created by 沈红榜 on 2021/6/1.
//

import UIKit
import ObjectiveC

extension UIControl {
    
    fileprivate struct Keys {
        static let hitEdgeKey = UnsafeRawPointer.init(bitPattern: "hitEdgeKey".hashValue)!
    }
        
    var hitEdgeInsets: UIEdgeInsets? {
        get {
            let k = objc_getAssociatedObject(self, Keys.hitEdgeKey)
            return k as? UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, Keys.hitEdgeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if isHidden || !isEnabled || hitEdgeInsets == nil {
            return super.point(inside: point, with: event)
        }
        
        let rect = CGRect(x: bounds.minX - hitEdgeInsets!.left,
                          y: bounds.minY - hitEdgeInsets!.top,
                          width: bounds.width + hitEdgeInsets!.left + hitEdgeInsets!.right,
                          height: bounds.height + hitEdgeInsets!.top + hitEdgeInsets!.bottom)
        
        return rect.contains(point)
    }
    
}
