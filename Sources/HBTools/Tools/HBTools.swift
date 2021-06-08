import UIKit
import CommonCrypto

public func HB_queryStr(_ param: Dictionary<String, Any>?) -> String? {
    
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

public func HB_bodyData(_ param: Dictionary<String, Any>?) -> Data? {
    
    guard let param = param else { return nil }
    
    if (param.count == 0) {
        return nil
    }
        
    return try? JSONSerialization.data(withJSONObject: param, options: [])
}


public func HB_phoneId() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
}

public func HB_hmacSha256(content: Data, secretKey: Data) -> String {
    
    var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    
    CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), (secretKey as NSData).bytes, secretKey.count, (content as NSData).bytes, content.count, &result)
    
    var kk = ""
    
    for item in result {
        kk += String(format: "%02x", item)
    }
    return kk
}



/// 回调主线程
///
/// - Parameter handler: 回调
public func HBInMainThread(_ handler: @escaping ()->Void) {
    if Thread.current.isMainThread {
        handler()
    } else {
        DispatchQueue.main.async {
            handler()
        }
    }
}

//MARK:- 文件夹路径

/// Documents 文件夹路径
public var DocumentPath: String {
    guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
        return NSHomeDirectory() + "/Documents"
    }
    return path
}


/// 在 Documents 文件夹下的文件夹路径，若不存在则创建
///
/// - Parameter folderName: 文件夹名称
/// - Returns: 路径
public func FolderPathInDocuments(with folderName: String) -> String {
    let path = DocumentPath + "/\(folderName)"
    
    let manager = FileManager.default
    
    var isDir: ObjCBool = false
    
    let existFile = manager.fileExists(atPath: path, isDirectory: &isDir)
    
    if existFile && !isDir.boolValue {
        //存在一个非文件夹的文件
        try? manager.removeItem(atPath: path)
    }
    
    //不存在文件夹，则创建
    if !existFile {
        try? manager.createDirectory(atPath: path, withIntermediateDirectories: true)
    }
    
    return path
}



