//
//  LSAlert.swift
//  Utils
//
//  Created by Lee on 2018/4/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

class LSAlert: NSObject {
    
    /// 提示框，有标题、内容的样式
    static func alertViewAlert(title:String,message:String,leftName:String,rightName:String,leftHandler: ((UIAlertAction) -> Swift.Void)? = nil,rightHandler: ((UIAlertAction) -> Swift.Void)? = nil){
        
        //标题字体样式（红色，字体放大）
        let titleFont = UIFont.systemFont(ofSize: 18)
        let titleAttribute = NSMutableAttributedString.init(string: title)
        titleAttribute.addAttributes([NSAttributedStringKey.font:titleFont,
                                      NSAttributedStringKey.foregroundColor:UIColor.colorFromHex(hexValue: 0x333333)],
                                     range:NSMakeRange(0, title.length))
        
        //内容
        let messageAtr = NSMutableAttributedString(string: message)
        messageAtr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15), range: NSRange(location: 0, length: message.length))
        messageAtr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.colorFromHex(hexValue: 0xababab), range: NSRange(location: 0, length: message.length))
        
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        vc.setValue(titleAttribute, forKey: "attributedTitle")
        vc.setValue(messageAtr, forKey: "attributedMessage")
        
        let actionLeft = UIAlertAction(title: leftName, style: .default) { (action) in
            leftHandler?(action)
        }
        actionLeft.setValue(UIColor.colorFromHex(hexValue: 0x999999), forKey:"titleTextColor")
        vc.addAction(actionLeft)
        
        let actionRight = UIAlertAction(title: rightName, style: .default) { (action) in
            rightHandler?(action)
        }
        actionRight.setValue(UIColor.colorFromHex(hexValue: 0x08b0bf), forKey:"titleTextColor")
        vc.addAction(actionRight)
        
        UIViewController.currentController().present(vc, animated: true, completion: nil)
    }
    

}
