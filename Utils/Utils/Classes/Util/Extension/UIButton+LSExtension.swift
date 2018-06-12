//
//  UIButton+LSExtension.swift
//  Utils
//
//  Created by Lee on 2018/6/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

import Foundation
import UIKit

/// 按钮布局样式（图片+文字）
enum ButtonLayoutStyle:UInt8 {
    ///图片居上
    case imageTop
    ///图片居下
    case imageBottom
    ///图片居左
    case imageLeft
    ///图片居右
    case imageRight
}

extension UIButton{
    
    
    /// 文字与图片位置布局（在布局完以后再调用此方法，不然可能会布局错乱）
    ///
    /// - Parameters:
    ///   - style: 样式
    ///   - padding: 间距（图片与文字间的间距）,默认2.0
    func layoutButton(_ style:ButtonLayoutStyle,padding:CGFloat = 2.0){
        self.contentMode = .center
        /**
         *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
         *  如果只有title，那它上下左右都是相对于button的，image也是一样；
         *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
         */
        // 1. 得到imageView和titleLabel的宽、高
        let imageWith = self.imageView?.frame.size.width ?? 0.0
        let imageHeight = self.imageView?.frame.size.height ?? 0.0
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0.0
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0.0
        
        // 2. 声明imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        // 3. 根据style和padding得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .imageTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-padding/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-padding/2.0, 0);
        case .imageBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-padding/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-padding/2.0, -imageWith, 0, 0);
        case .imageLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -padding/2.0, 0, padding/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, padding/2.0, 0, -padding/2.0);
        case .imageRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+padding/2.0, 0, -(labelWidth+padding/2.0));
            labelEdgeInsets = UIEdgeInsetsMake(0, -(imageWith+padding/2.0), 0, imageWith+padding/2.0);
        }
        
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        
    }
    
}


