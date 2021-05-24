import UIKit
import CommonCrypto

func hb_queryStr(_ param: Dictionary<String, Any>?) -> String? {
    
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

func hb_bodyData(_ param: Dictionary<String, Any>?) -> Data? {
    
    guard let param = param else { return nil }
    
    if (param.count == 0) {
        return nil
    }
        
    return try? JSONSerialization.data(withJSONObject: param, options: [])
}


func hb_phoneId() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
}

func hb_hmacSha256(content: Data, secretKey: Data) -> String {
    
    var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    
    CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), (secretKey as NSData).bytes, secretKey.count, (content as NSData).bytes, content.count, &result)
    
    var kk = ""
    
    for item in result {
        kk += String(format: "%02x", item)
    }
    return kk
}

func toInt(_ num: Any?) -> Int {
    

    if let a = num as? Int {
        return a
    }
    
    if let a = num as? String {
        if let k = Int(a) {
            return k
        }
    }
    return 0
}

func toDouble(_ obj: Any?) -> Double {
    if let a = obj as? Double {
        return a
    }
    
    if let a = obj as? String {
        if let k = Double(a) {
            return k
        }
    }
    return 0
}

func toString(_ obj: Any?) -> String {
    if let a = obj as? String {
        return a
    }
    return ""
}

func toBool(_ obj: Any?) -> Bool {
    if let a = obj as? Bool {
        return a
    }
    if let a = obj as? Int {
        return a != 0
    }
    
    if let a = obj as? String {
        let b = a.lowercased()
        return b == "yes" || b == "true"
    }
    
    return false
}



