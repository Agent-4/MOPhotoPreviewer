//
//  UIView+MOExtension.swift
//  Mo
//
//  Created by 莫晓豪 on 2017/3/22.
//  Copyright © 2017年 莫晓豪. All rights reserved.
//

import UIKit

extension UIView {
    
    public var mo_x: CGFloat {
        
        get {
            return self.frame.origin.x
        }
        
        set(newVal) {
            var mo_frame: CGRect = self.frame
            mo_frame.origin.x = newVal
            self.frame = mo_frame
        }
    }
    
    public var mo_y: CGFloat {
        
        get {
            return self.frame.origin.y
        }
        
        set(newVal) {
            var mo_frame: CGRect = self.frame
            mo_frame.origin.y = newVal
            self.frame = mo_frame
        }
    }
    
    public var mo_width: CGFloat {
        
        get {
            return self.frame.size.width
        }
        
        set(newVal) {
            var mo_frame: CGRect = self.frame
            mo_frame.size.width = newVal
            self.frame = mo_frame
        }
    }
    
    public var mo_height: CGFloat {
        
        get {
            return self.frame.size.height
        }
        
        set(newVal) {
            var mo_frame: CGRect = self.frame
            mo_frame.size.height = newVal
            self.frame = mo_frame
        }
    }
    
    public var mo_origin: CGPoint {
        
        get {
            return self.frame.origin
        }
        
        set(newVal) {
            var mo_origin: CGRect = self.frame
            mo_origin.origin = newVal
            self.frame = mo_origin
        }
    }
    
    public var mo_frameSize: CGSize {
        
        get {
            return self.frame.size
        }
        
        set(newVal) {
            var mo_frame: CGRect = self.frame
            mo_frame.size = newVal
            self.frame = mo_frame
        }
    }
    
    public var mo_center: CGPoint {
        
        get {
            return CGPoint(x: CGFloat(self.frame.origin.x + self.frame.size.width * 0.5),
                           y: CGFloat(self.frame.origin.y + self.frame.size.height * 0.5))
        }
        
        set(newVal) {
            var mo_frame: CGRect = self.frame
            mo_frame.origin.x = newVal.x - mo_frame.size.width * 0.5
            mo_frame.origin.y = newVal.y - mo_frame.size.width * 0.5
            self.frame = mo_frame
        }
    }
    
    public var mo_centerX: CGFloat {
        
        get {
            return self.center.x
        }
        
        set(newVal) {
            var mo_center: CGPoint = self.center
            mo_center.x = newVal
            self.center = mo_center
        }
    }
    
    public var mo_centerY: CGFloat {
        
        get {
            return self.center.y
        }
        
        set(newVal) {
            var mo_center: CGPoint = self.center
            mo_center.y = newVal
            self.center = mo_center
        }
    }
    
    /// 获取响应链上的UIViewController
    ///
    /// - Returns: UIViewController?
    func currentViewController() -> UIViewController?{
        var responder:UIResponder? = self.next
        while responder != nil {
            if (responder?.isKind(of: UIViewController.self)) == true {
                let con = responder as? UIViewController
                return con
            }else {
                responder = responder?.next
            }
        }
        return nil
    }
}

