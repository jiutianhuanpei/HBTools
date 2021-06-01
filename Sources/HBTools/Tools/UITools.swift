//
//  File.swift
//  
//
//  Created by 沈红榜 on 2021/6/1.
//

import UIKit

public func RootWindow() -> UIWindow? {
    if #available(iOS 13, *) {
        for item in UIApplication.shared.connectedScenes {
            if let scene = item as? UIWindowScene {
                if scene.activationState == .foregroundActive {
                    return scene.windows.first
                }
            }
        }
        return nil
    } else {
        return UIApplication.shared.keyWindow
    }
}

public func CurrentVC() -> UIViewController {
    
    func findBastVC(_ vc: UIViewController) -> UIViewController {
        
        if let v = vc.presentedViewController {
            return findBastVC(v)
        }
        
        if vc.isKind(of: UISplitViewController.self) {
            let v = vc as! UISplitViewController
            if v.viewControllers.count > 0 {
                return findBastVC(v.viewControllers.last!)
            }
            return v
        }
        
        if vc.isKind(of: UINavigationController.self) {
            let v = vc as! UINavigationController
            if v.viewControllers.count > 0 {
                return findBastVC(v.viewControllers.last!)
            }
            return v
        }
        
        if vc.isKind(of: UITabBarController.self) {
            let v = vc as! UITabBarController
            
            if let vcs = v.viewControllers {
                if vcs.count > 0 {
                    return findBastVC(v.selectedViewController!)
                }
            }
            return v
        }
        return vc
    }
    
    let win = RootWindow()!
    let resultVC = findBastVC(win.rootViewController!)
    
    return resultVC
}












































