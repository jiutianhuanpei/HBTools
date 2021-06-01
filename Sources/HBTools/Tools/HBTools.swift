import UIKit
import CommonCrypto

public func hb_queryStr(_ param: Dictionary<String, Any>?) -> String? {
    
    guard let param = param else { return nil }
    
    if (param.count == 0) {
        return ""
    }
    
    var arr: [String] = []
    
    for (k, v) in param {
        
        let s = "\(k)=\(v)"
        arr.append(s)
    }
    
    return arr.joined(separator: "&")
}

public func hb_bodyData(_ param: Dictionary<String, Any>?) -> Data? {
    
    guard let param = param else { return nil }
    
    if (param.count == 0) {
        return nil
    }
        
    return try? JSONSerialization.data(withJSONObject: param, options: [])
}


public func hb_phoneId() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
}

public func hb_hmacSha256(content: Data, secretKey: Data) -> String {
    
    var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    
    CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), (secretKey as NSData).bytes, secretKey.count, (content as NSData).bytes, content.count, &result)
    
    var kk = ""
    
    for item in result {
        kk += String(format: "%02x", item)
    }
    return kk
}




