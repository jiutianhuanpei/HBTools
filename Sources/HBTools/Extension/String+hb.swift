//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/5/24.
//

import Foundation
import CommonCrypto

public extension String {
    
    func md5() -> String {
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
    
    
}

