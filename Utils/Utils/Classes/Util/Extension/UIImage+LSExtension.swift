//
//  UIImage+LSExtension.swift
//  Utils
//
//  Created by Lee on 2018/8/8.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

extension UIImage {
    /// 绘制纯色图片
    class func imageFromColor(_ color: UIColor, size: CGSize) -> UIImage? {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image
    }
}
