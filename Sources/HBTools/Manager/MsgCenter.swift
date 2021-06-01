//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/5/24.
//

import Foundation


public typealias NotiCallback = (_ key: String, _ info: Any)->Void

fileprivate class MsgCallback {
    init(_ tmpCallback: @escaping NotiCallback) {
        callback = tmpCallback
    }
    
    var callback: NotiCallback
    
}

public class MsgCenter {
    public static let shared = MsgCenter()
    
    
    private let notiKey: Notification.Name = Notification.Name(rawValue: "hb_notiKey")
    private var weakTable: NSMapTable = NSMapTable<AnyObject, MsgCallback>.weakToStrongObjects()
    
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(m_didReceivedNoti(nofi:)), name: notiKey, object: nil)
    }
    
    
    /// 发送消息
    /// - Parameters:
    ///   - key: 关键字  以此区分消息来源
    ///   - info: 携带拓展信息
    /// - Returns: nil
    public func sendMsg(key: String, info: Any = "") -> Void {
        
        var param:[String: Any] = [:]
        param["key"] = key
        param["value"] = info
        
        NotificationCenter.default.post(name: notiKey, object: param)
    }
    
    /// 监听接收消息
    /// - Parameters:
    ///   - target: 接收消息的目标，可自动释放
    ///   - callback: 回调
    /// - Returns: nil
    public func addObserver(_ target: AnyObject, callback: @escaping NotiCallback) -> Void {
        
        let ca = MsgCallback(callback)
        weakTable.setObject(ca, forKey: target)
    }
    
    /// 删除监听消息
    /// - Parameter target: 要删除的监听目标
    /// - Returns: nil
    public func removeObserver(_ target: AnyObject) -> Void {
        weakTable.removeObject(forKey: target)
    }
    
    
    @objc
    private func m_didReceivedNoti(nofi: Notification) -> Void {
        
        guard let obj = nofi.object as? [String:Any] else { return }
        
        if let objs = weakTable.objectEnumerator() {
            for item in objs {
                
                let cal = item as! MsgCallback
                cal.callback(obj["key"] as! String, obj["value"] as Any)
            }
        }
    }
}

