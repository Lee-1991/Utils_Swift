//
//  LSHUD.swift
//  Utils
//
//  Created by Lee on 2018/8/9.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

//******* 配置参数 *************//
fileprivate let LSHUD_DelayInterval = 1.5
fileprivate let LSHUD_Padding : CGFloat = 10
fileprivate let LSHUD_CornerRadiusHasImage : CGFloat = 13.0
fileprivate let LSHUD_CornerRadiusPureText: CGFloat = 6.0
fileprivate let LSHUD_ImageWidth_Height : CGFloat = 36
fileprivate let LSHUD_WidthHaveText: CGFloat = 110
fileprivate let LSHUD_WidthWithoutText: CGFloat = 90
fileprivate let LSHUD_Height: CGFloat = 90
fileprivate let LSHUD_TextFont = UIFont.systemFont(ofSize: 13)

fileprivate let keyWindow = UIApplication.shared.keyWindow!

public class LSHUD:UIView {
    
    enum LSHUDType {
        case success // image + text
        case error   // image + text
        case info    // image + text
        case loading // image
        case text    // text
    }
    
    private var delay : TimeInterval = LSHUD_DelayInterval
    private var imageView :UIImageView?
    private var cornerRadius : CGFloat = LSHUD_CornerRadiusHasImage
    private var type : LSHUDType?
    private var text : String?
    private var selfWidth:CGFloat = LSHUD_WidthWithoutText
    private var selfHeight:CGFloat = LSHUD_Height
    
    init(text:String?,type:LSHUDType,delay:TimeInterval) {
        self.delay = delay
        self.text = text
        self.type = type
        if type == .text {
            cornerRadius = LSHUD_CornerRadiusPureText
        }
        
        super.init(frame: CGRect(origin: CGPoint.zero,
                                 size: CGSize(width: selfWidth,
                                              height: selfHeight)))
        config()
    }
    
    private func config() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.layer.cornerRadius = cornerRadius
        
        if text != nil {
            selfWidth = LSHUD_WidthHaveText
        }
        
        guard let type = type else { return }
        switch type {
        case .success:
            addImageView(image: LSHUDImage.imageOfSuccess)
        case .error:
            addImageView(image: LSHUDImage.imageOfError)
        case .info:
            addImageView(image: LSHUDImage.imageOfInfo)
        case .loading:
            addActivityView()
        case .text:
            break
        }
        
        addLabel()
        addSelfToKeyWindow()
    }
    
    private func addSelfToKeyWindow() {
        guard self.superview == nil else { return }
        keyWindow.addSubview(self)
        self.alpha = 0
        
        addConstraint(width: selfWidth, height: selfHeight) //
        keyWindow.addConstraint(toCenterX: self, constantx: 0, toCenterY: self, constanty: -50)
    }
    
    private func addLabel() {
        
        var labelY:CGFloat = 0.0
        if type == .text {
            labelY = LSHUD_Padding
        } else {
            labelY = LSHUD_Padding * 2 + LSHUD_ImageWidth_Height
        }
        if let text = text {
            textLabel.text = text
            addSubview(textLabel)
            
            addConstraint(to: textLabel,
                          edageInset: UIEdgeInsets(top: labelY,
                                                   left: LSHUD_Padding/2,
                                                   bottom: -LSHUD_Padding,
                                                   right: -LSHUD_Padding/2))
            let textSize:CGSize = size(from: text)
            selfHeight = textSize.height + labelY + LSHUD_Padding + 2
        }
    }
    
    private func size(from text:String) -> CGSize {
        return text.textSizeWithFont(font: LSHUD_TextFont,
                                     constrainedToSize:
            CGSize(width:selfWidth - LSHUD_Padding, height:CGFloat(MAXFLOAT)))
    }
    
    private func addImageView(image:UIImage) {
        
        imageView = UIImageView(image: image)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView!)
        
        generalConstraint(at: imageView!)
    }
    
    private func addActivityView() {
        
        addSubview(activityView)
        generalConstraint(at: activityView)
    }
    
    private func generalConstraint(at view:UIView) {
        
        view.addConstraint(width: LSHUD_ImageWidth_Height,
                           height: LSHUD_ImageWidth_Height)
        if let _ = text {
            addConstraint(toCenterX: view, toCenterY: nil)
            addConstraint(with: view,
                          topView: self,
                          leftView: nil,
                          bottomView: nil,
                          rightView: nil,
                          edgeInset: UIEdgeInsets(top: LSHUD_Padding, left: 0, bottom: 0, right: 0))
        } else {
            addConstraint(toCenterX: view, toCenterY: view)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = LSHUD_TextFont
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    //    private lazy var textLabel:UILabel = {
    //        $0.translatesAutoresizingMaskIntoConstraints = false
    //        $0.textColor = UIColor.white
    //        $0.font = LSHUD_TextFont
    //        $0.numberOfLines = 0
    //        $0.textAlignment = .center
    //        return $0
    //    }(UILabel())
    
    public override func updateConstraints() {
        super.updateConstraints()
    }
}

// MARK: LSHUD func
extension LSHUD {
    
    static func showSuccess(_ text: String?, delay: TimeInterval = LSHUD_DelayInterval) {
        LSHUD(text: text, type: .success, delay: delay).show()
    }
    
    static func showError(_ text: String?, delay: TimeInterval = LSHUD_DelayInterval) {
        LSHUD(text: text, type: .error, delay: delay).show()
    }
    
    //    static func showLoading() {
    //        LSHUD(text: nil,type:.loading,delay: 0).show()
    //    }
    //
    static func showLoading(_ text: String? = nil) {
        LSHUD(text: text,type:.loading,delay: 0).show()
    }
    
    static func showInfo(_ text: String?, delay: TimeInterval = LSHUD_DelayInterval) {
        LSHUD(text: text, type: .info, delay: delay).show()
    }
    
    static func showText(_ text: String?, delay: TimeInterval = LSHUD_DelayInterval) {
        LSHUD(text: text,type:.text,delay: delay).show()
    }
    
    public func show() {
        self.animate(hide: false) {
            if self.delay > 0 {
                self.asyncAfter(duration: self.delay, completion: {
                    self.hide()
                })
            }
        }
    }
    
    //MARK: Hide func
    public func hide() {
        self.animate(hide: true, completion: {
            self.removeFromSuperview()
        })
    }
    
    func hide(delay:TimeInterval = LSHUD_DelayInterval) {
        asyncAfter(duration: delay) {
            self.hide()
        }
    }
    
    static func hide() {
        for view in keyWindow.subviews {
            if view.isKind(of:self) {
                view.animate(hide: true, completion: {
                    view.removeFromSuperview()
                })
            }
        }
    }
    
}

//MARK: Extension LSHUD
extension LSHUD {
    
    fileprivate func asyncAfter(duration:TimeInterval,
                                completion:(() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration,
                                      execute: {
                                        completion?()
        })
    }
}

//MARK: Extension String
extension String {
    
    fileprivate func textSizeWithFont(font: UIFont,
                                      constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = [NSAttributedStringKey.font: font]
            textSize = self.size(withAttributes: attributes)
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = [NSAttributedStringKey.font: font]
            
            let stringRect = self.boundingRect(with: size,
                                               options: option,
                                               attributes: attributes,
                                               context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}

//MARK: Extension UIView
extension UIView {
    fileprivate func animate(hide:Bool,
                             completion:(() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        if hide {
                            self.alpha = 0
                        }else {
                            self.alpha = 1
                        }
        }) { _ in
            completion?()
        }
    }
}

//MARK: Class LSHUDImage
private class LSHUDImage {
    fileprivate struct HUD {
        static var imageOfSuccess: UIImage?
        static var imageOfError: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    fileprivate class func draw(_ type: LSHUD.LSHUDType) {
        let checkmarkShapePath = UIBezierPath()
        
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18),
                                  radius: 17.5,
                                  startAngle: 0,
                                  endAngle: CGFloat(Double.pi*2),
                                  clockwise: true)
        checkmarkShapePath.close()
        
        switch type {
        case .success:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()
            
            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27),
                                      radius: 1,
                                      startAngle: 0,
                                      endAngle: CGFloat(Double.pi*2),
                                      clockwise: true)
            checkmarkShapePath.close()
            
            UIColor.white.setFill()
            checkmarkShapePath.fill()
        case .loading:
            break
        case .text:
            break
        }
        
        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
    }
    
    fileprivate static var imageOfSuccess :UIImage {
        
        guard HUD.imageOfSuccess == nil else { return HUD.imageOfSuccess! }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: LSHUD_ImageWidth_Height,
                                                      height: LSHUD_ImageWidth_Height),
                                               false, 0)
        LSHUDImage.draw(.success)
        HUD.imageOfSuccess = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return HUD.imageOfSuccess!
    }
    
    fileprivate static var imageOfError : UIImage {
        
        guard HUD.imageOfError == nil else { return HUD.imageOfError! }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: LSHUD_ImageWidth_Height,
                                                      height: LSHUD_ImageWidth_Height),
                                               false, 0)
        LSHUDImage.draw(.error)
        HUD.imageOfError = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return HUD.imageOfError!
    }
    
    fileprivate static var imageOfInfo : UIImage {
        
        guard HUD.imageOfInfo == nil else { return HUD.imageOfInfo! }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: LSHUD_ImageWidth_Height,
                                                      height: LSHUD_ImageWidth_Height),
                                               false, 0)
        LSHUDImage.draw(.info)
        HUD.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return HUD.imageOfInfo!
    }
    
}

//MARK: Extension UIView
extension UIView {
    
    fileprivate func addConstraint(width: CGFloat,height:CGFloat) {
        if width>0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutAttribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: width))
        }
        if height>0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutAttribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: height))
        }
    }
    
    fileprivate func addConstraint(toCenterX xView:UIView?,toCenterY yView:UIView?) {
        addConstraint(toCenterX: xView, constantx: 0, toCenterY: yView, constanty: 0)
    }
    
    func addConstraint(toCenterX xView:UIView?,
                       constantx:CGFloat,
                       toCenterY yView:UIView?,
                       constanty:CGFloat) {
        if let xView = xView {
            addConstraint(NSLayoutConstraint(item: xView,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerX,
                                             multiplier: 1, constant: constantx))
        }
        if let yView = yView {
            addConstraint(NSLayoutConstraint(item: yView,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: constanty))
        }
    }
    
    fileprivate func addConstraint(to view:UIView,edageInset:UIEdgeInsets) {
        addConstraint(with: view,
                      topView: self,
                      leftView: self,
                      bottomView: self,
                      rightView: self,
                      edgeInset: edageInset)
    }
    
    fileprivate func addConstraint(with view:UIView,
                                   topView:UIView?,
                                   leftView:UIView?,
                                   bottomView:UIView?,
                                   rightView:UIView?,
                                   edgeInset:UIEdgeInsets) {
        if let topView = topView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: topView,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: edgeInset.top))
        }
        if let leftView = leftView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .left,
                                             relatedBy: .equal,
                                             toItem: leftView,
                                             attribute: .left,
                                             multiplier: 1,
                                             constant: edgeInset.left))
        }
        if let bottomView = bottomView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: bottomView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: edgeInset.bottom))
        }
        if let rightView = rightView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .right,
                                             relatedBy: .equal,
                                             toItem: rightView,
                                             attribute: .right,
                                             multiplier: 1,
                                             constant: edgeInset.right))
        }
    }
}

