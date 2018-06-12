//
//  String+LSExtension.swift
//  Utils
//
//  Created by Lee on 2018/4/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

extension String{
    
    
    /// 截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return String(self[startIndex..<endIndex])
        }
    }
    
    
    public var length: Int { return self.count }
    
    /// 计算字符串长度，中文只算两个字符，英文1算一个字符
    func lengthFormat()->Int{
        var length = 0
        for char in self {
            length += "\(char)".lengthOfBytes(using: String.Encoding.utf8) == 3 ? 2:1
        }
        return length
    }
    
    /// 裁剪到指定长度，字母长度为1，汉字为2
    func subLength(_ length:Int) -> String{
        var strlength = 0
        var targetLength = 0
        for char in self.enumerated() {
            strlength += "\(char.element)".lengthOfBytes(using: String.Encoding.utf8) == 3 ? 2:1
            if strlength > length {
                break
            }
            targetLength = char.offset + 1
        }
        
        return self[0..<targetLength]
    }
    
    public func toURL() -> NSURL? {
        return NSURL(string: self)
    }
    
    /// 文本是否包含汉字
    func isIncludeChinese() -> Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") { return true }
        }
        return false
    }
    
    /// 根据字符串获取高度
    func height(_ font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let tempStr = self as NSString
        return tempStr.boundingRect(with: CGSize.init(width: maxWidth, height: 1000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size.height
    }
}
