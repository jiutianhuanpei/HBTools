//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/5/24.
//

import Foundation

public extension Dictionary {
    
    mutating func hb_addEntries(fromDic: Dictionary?) -> Void {
        
        if let dic = fromDic {
            for item in dic {
                self.updateValue(item.value, forKey: item.key)
            }
        }
    }
    
    
}
