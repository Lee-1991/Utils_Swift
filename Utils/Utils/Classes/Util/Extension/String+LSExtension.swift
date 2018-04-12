//
//  String+LSExtension.swift
//  Utils
//
//  Created by Lee on 2018/4/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

extension String{
    public var length: Int { return self.count }
    
    public func toURL() -> NSURL? {
        return NSURL(string: self)
    }
}
