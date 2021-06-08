//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/5/24.
//

import Foundation
import CommonCrypto

public extension String {
    
    var md5: String {
        let utf8 = cString(using: .utf8)
        var result = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &result)
        
        return result.reduce("") { a, b in
            return a + String(format: "%02x", b)
        }
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    

    func hmacSha256(key: String) -> Data {
        
        let cKey = key.cString(using: .utf8)!
        let cData = cString(using: .utf8)!
        
        var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cKey, strlen(cKey), cData, strlen(cData), &result)
        
        let data = Data(bytes: result, count:Int(CC_SHA256_DIGEST_LENGTH))
        return data
    }
    
    func sha256() -> Data {
        
        let keyData = cString(using: .utf8)!
        
        var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        CC_SHA256(keyData, CC_LONG(strlen(keyData)), &result)
        
        
        let data = Data(bytes: result, count:Int(CC_SHA256_DIGEST_LENGTH))
        return data
    }
    
    /// 字符串截取
    ///
    /// - Parameter range: 区间
    /// - Returns: 子字符串
    func subString<T>(_ range: T) -> String {
        
        let begin = startIndex
        
        func hb_stringIndex(_ i: Int) -> String.Index {
            return index(begin, offsetBy: i)
        }
        
        if let kRange = range as? Range<Int> {
            
            let begin = hb_stringIndex(kRange.lowerBound)
            let end = hb_stringIndex(kRange.upperBound)
            return String(self[begin..<end])
            
        } else if let kRange = range as? ClosedRange<Int> {
            
            let begin = hb_stringIndex(kRange.lowerBound)
            let end = hb_stringIndex(kRange.upperBound)
            return String(self[begin...end])
            
        } else if let kRange = range as? PartialRangeThrough<Int> {
            
            let end = hb_stringIndex(kRange.upperBound)
            return String(self[...end])
            
        } else if let kRange = range as? PartialRangeUpTo<Int> {
            
            let end = hb_stringIndex(kRange.upperBound)
            return String(self[..<end])
            
        } else if let kRange = range as? PartialRangeFrom<Int> {
            
            let begin = hb_stringIndex(kRange.lowerBound)
            return String(self[begin...])
        }
        
        return ""
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        
        
        guard let fromIndex = index(startIndex, offsetBy: range.location, limitedBy: endIndex) else { return nil }
        
        guard let toIndex = index(startIndex, offsetBy: range.location + range.length, limitedBy: endIndex) else { return nil }
        
        return fromIndex..<toIndex
    }
    
    func toNSRange(_ range: Range<String.Index>) -> NSRange? {
        
        guard let from = range.lowerBound.samePosition(in: utf16) else { return nil }
        guard let to = range.upperBound.samePosition(in: utf16) else { return nil }
        
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from), length: utf16.distance(from: from, to: to))
    }
    
    /// 获取子字符串在字符串中的位置
    ///
    /// - Parameter str: 子字符串
    /// - Returns: 位置，若不在，则 range.location == NSNotFound
    func range(with str: String) -> NSRange {
        
        guard let r = range(of: str) else {
            return NSMakeRange(NSNotFound, 0)
        }
        
        guard let range = self.toNSRange(r) else {
            return NSMakeRange(NSNotFound, 0)
        }
        return range
    }
    
    /// 返回字符串 utf8 编码下的 data，若转换失败则返回 Data()， 其 isEmpty 值为 true
    var data: Data {
        
        if let a = self.data(using: .utf8) {
            return a
        }
        return Data()
    }
}

