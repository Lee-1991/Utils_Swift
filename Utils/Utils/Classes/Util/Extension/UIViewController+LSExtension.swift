//
//  UIViewController+LSExtension.swift
//  Utils
//
//  Created by Lee on 2018/4/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

extension UIViewController{
    /// 当前的控制器
    class func currentController() -> UIViewController {
        var vc = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers.last
        if vc == nil {
            vc = UIViewController()
        }
        return vc!
        //        let vc = UIApplication.shared.keyWindow?.rootViewController
        //        return UIViewController.findBestViewController(vc: vc!)
    }
}
