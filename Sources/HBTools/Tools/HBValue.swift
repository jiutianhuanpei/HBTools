//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/6/1.
//

import Foundation

public struct HBValue {
    
    public static func toInt(_ obj: Any?) -> Int {
        
        guard let obj = obj else { return 0 }
        
        if obj is Int {
            return toObj(obj, default: 0)
        }
        
        if obj is String {
            return Int(toObj(obj, default: "0")) ?? 0
        }
        
        if obj is Bool {
            return toObj(obj, default: false) ? 1 : 0
        }
        
        if obj is NSNumber {
            return toObj(obj, default: NSNumber(0)).intValue
        }
        return 0
    }
    
    public static func toDouble(_ obj: Any?) -> Double {
        guard let obj = obj else { return 0 }
        
        if obj is Double {
            return toObj(obj, default: 0.0)
        }
        
        if obj is String {
            return Double(toObj(obj, default: "0")) ?? 0.0
        }
        
        if obj is Bool {
            return toObj(obj, default: false) ? 1 : 0
        }
        
        if obj is NSNumber {
            return toObj(obj, default: NSNumber(0)).doubleValue
        }
        return 0
    }
    
    public static func toFloat(_ obj: Any?) -> Float {
        guard let obj = obj else { return 0 }
        
        if obj is Float {
            return toObj(obj, default: Float(0))
        }
        
        if obj is String {
            return Float(toObj(obj, default: Float(0)))
        }
        
        if obj is Bool {
            return toObj(obj, default: false) ? 1 : 0
        }
        
        if obj is NSNumber {
            return toObj(obj, default: NSNumber(0)).floatValue
        }
        return 0
    }
    
    
    public static func toBool(_ obj: Any?) -> Bool {
        guard let obj = obj else { return false }
        
        if obj is Int {
            return toObj(obj, default: 0) != 0
        }
        
        if obj is String {
            let str = toObj(obj, default: "")
            return str == "true" || str == "yes"
        }
        
        if obj is Bool, let a = obj as? Bool {
            return a
        }
        
        if obj is NSNumber, let a = obj as? NSNumber {
            return a.boolValue
        }
        return false
    }
    
    public static func toString(_ obj: Any?) -> String {
        guard let obj = obj else { return "" }
        
        if obj is Int, let a = obj as? Int {
            return "\(a)"
        }
        
        if obj is String, let a = obj as? String {
            return a
        }
        
        if obj is Bool, let a = obj as? Bool {
            return "\(a)"
        }
        
        if obj is NSNumber, let a = obj as? NSNumber {
            return "\(a)"
        }
        return "\(obj)"
    }
    
    public static func toDictionary(_ obj: Any?) -> [String:Any] {
        let p: [String:Any] = [:]
        let result = toObj(obj, default: p)
        return result
    }
    
    public static func toArray<T>(_ obj: Any?) -> [T] {
        let p: [T] = []
        let result = toObj(obj, default: p)
        return result
    }
    
    public static func toObj<T>(_ obj: Any?, `default`: T) -> T {
        guard let obj = obj else { return `default` }
        
        if obj is T, let a = obj as? T {
            return a
        }
        return `default`
    }
    
}
