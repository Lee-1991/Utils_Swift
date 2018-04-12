//
//  UIColor+LSExtension.swift
//  Utils
//
//  Created by Lee on 2018/4/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

extension UIColor{

    /// 通过hex值获取颜色
    ///
    /// - Parameters:
    ///   - hexValue: 十六进制颜色 (0x0F0F0F)
    ///   - alpha: 透明度（0～1.0）
    class func colorFromHex(hexValue: Int,alpha:CGFloat = 1.0) -> UIColor {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                       alpha: alpha)
    }

    /// 通过hex字符串获取颜色
    ///
    /// - Parameters:
    ///   - hexValue: 例如"FFFFFF"
    ///   - alpha: 透明度（0～1）
    class func colorFromHex(hexValue: String,alpha: CGFloat = 1.0) -> UIColor {
        //处理数值
        var cString = hexValue.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回redColor
            return UIColor.red
            
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}
