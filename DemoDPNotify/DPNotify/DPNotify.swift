//
//  DPNotify.swift
//  DemoDPNotify
//
//  Created by @baophan94 on 6/26/15.
//  Contact: www.dinophan.com - baophan94@icloud.com
//  Copyright (c) 2015 @baophan94. All rights reserved.
//
//  A guide to the main features is available at:
//  www.dinophan.com
//

import UIKit

/************* USAGE ******************

* Show notify:

    showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool) {}
    showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNotifyType) {}
    showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNotifyType, delay: NSTimeInterval) {}
    showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNotifyType, delay: NSTimeInterval, completionHandler: () -> Void) {}


* Dismiss notify:

    dismissNotify() {}
    dismissNotify(completion: () -> Void) {}

***************************************/

enum DPNotifyType {
    case DEFAULT
    case DANGER
    case WARNING
    case SUCCESS
    case DISABLED
}

class DPNotify: NSObject {
    
    static let sharedNotify = DPNotify()
    
    var bannerBackgroundColor: UIColor! = UIColor(white: 0.2, alpha: 0.7)
    var bannerForegroundColor: UIColor! = UIColor.whiteColor()
    var tapToDismiss: Bool! = true
    var delayTimer: NSTimeInterval! = 1.0
    var bannerType: DPNotifyType! = .DEFAULT
    var notifyTitle: String! = ""
    var notifyTitleFont: UIFont! = UIFont.systemFontOfSize(17.0)
    private var bannerView: UIView!
    private var tapGesture: UITapGestureRecognizer?
    
    
    func showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        self.notifyTitle = title
        self.tapToDismiss = dismissOnTap
        
        let containerFrame: CGRect = inView.frame
        self.bannerView = UIView()
        self.bannerView.backgroundColor = self.bannerBackgroundColor
        
        var calculationView: UITextView = UITextView()
        calculationView.attributedText = NSAttributedString(string: self.notifyTitle, attributes:
            [
                NSFontAttributeName: notifyTitleFont
            ])
        let size: CGSize = calculationView.sizeThatFits(
            CGSizeMake(containerFrame.width - 16, CGFloat(FLT_MAX)))
        var titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 16, size.height))
        titleView = applyTextViewStyle(titleView)
        self.bannerView.addSubview(titleView)
        self.bannerView.alpha = 0
        self.bannerView.frame = CGRectMake(0, -titleView.frame.size.height, containerFrame.width, titleView.frame.size.height)
        inView.addSubview(self.bannerView)
        
        addTapToDismissGesture()
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bannerView.alpha = 1
            titleView.alpha = 1
            self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height + 5)
        }) { (Bool) -> Void in
            if self.bannerView != nil {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height)
                }, completion: { (Bool) -> Void in
                    
                })
            }
        }
    }
    
    func showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNotifyType) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        switch notifyType {
        case DPNotifyType.DEFAULT: self.applyDefaultType()
        case DPNotifyType.DANGER: self.applyDangerType()
        case DPNotifyType.DISABLED: self.applyDisabledType()
        case DPNotifyType.SUCCESS: self.applySuccessType()
        case DPNotifyType.WARNING: self.applyWarningType()
        default: self.applyDefaultType()
        }
        
        self.notifyTitle = title
        self.tapToDismiss = dismissOnTap
        
        let containerFrame: CGRect = inView.frame
        self.bannerView = UIView()
        self.bannerView.backgroundColor = self.bannerBackgroundColor
        
        var calculationView: UITextView = UITextView()
        calculationView.attributedText = NSAttributedString(string: self.notifyTitle, attributes:
            [
                NSFontAttributeName: notifyTitleFont
            ])
        let size: CGSize = calculationView.sizeThatFits(
            CGSizeMake(containerFrame.width - 16, CGFloat(FLT_MAX)))
        var titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 16, size.height))
        titleView = applyTextViewStyle(titleView)
        self.bannerView.addSubview(titleView)
        self.bannerView.alpha = 0
        self.bannerView.frame = CGRectMake(0, -titleView.frame.size.height, containerFrame.width, titleView.frame.size.height)
        inView.addSubview(self.bannerView)
        
        if dismissOnTap == true {
            addTapToDismissGesture()
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bannerView.alpha = 1
            titleView.alpha = 1
            self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height + 5)
            }) { (Bool) -> Void in
                if self.bannerView != nil {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height)
                        })
                }
        }
    }
    
    func showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNotifyType, delay: NSTimeInterval) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        switch notifyType {
        case DPNotifyType.DEFAULT: self.applyDefaultType()
        case DPNotifyType.DANGER: self.applyDangerType()
        case DPNotifyType.DISABLED: self.applyDisabledType()
        case DPNotifyType.SUCCESS: self.applySuccessType()
        case DPNotifyType.WARNING: self.applyWarningType()
        default: self.applyDefaultType()
        }
        
        self.delayTimer = delay
        
        self.notifyTitle = title
        self.tapToDismiss = dismissOnTap
        
        let containerFrame: CGRect = inView.frame
        self.bannerView = UIView()
        self.bannerView.backgroundColor = self.bannerBackgroundColor
        
        var calculationView: UITextView = UITextView()
        calculationView.attributedText = NSAttributedString(string: self.notifyTitle, attributes:
            [
                NSFontAttributeName: notifyTitleFont
            ])
        let size: CGSize = calculationView.sizeThatFits(
            CGSizeMake(containerFrame.width - 16, CGFloat(FLT_MAX)))
        var titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 16, size.height))
        titleView = applyTextViewStyle(titleView)
        self.bannerView.addSubview(titleView)
        self.bannerView.alpha = 0
        self.bannerView.frame = CGRectMake(0, -titleView.frame.size.height, containerFrame.width, titleView.frame.size.height)
        inView.addSubview(self.bannerView)
        
        if dismissOnTap == true {
            addTapToDismissGesture()
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bannerView.alpha = 1
            titleView.alpha = 1
            self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height + 5)
            }) { (Bool) -> Void in
                if self.bannerView != nil {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height)
                        }, completion: { (Bool) -> Void in
                            if self.delayTimer > 0 {
                                UIView.animateWithDuration(self.delayTimer, animations: { () -> Void in
                                    if self.bannerView != nil {
                                        self.bannerView.alpha = 0.8
                                    }
                                    }, completion: { (cpl) -> Void in
                                        if cpl == true {
                                            self.dismissNotify()
                                        }
                                })
                            }
                    })
                }
        }
    }
    
    func showNotifyInView(
        inView: UIView,
        title: String,
        dismissOnTap: Bool,
        notifyType: DPNotifyType,
        delay: NSTimeInterval,
        completionHandler: () -> Void) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        switch notifyType {
        case DPNotifyType.DEFAULT: self.applyDefaultType()
        case DPNotifyType.DANGER: self.applyDangerType()
        case DPNotifyType.DISABLED: self.applyDisabledType()
        case DPNotifyType.SUCCESS: self.applySuccessType()
        case DPNotifyType.WARNING: self.applyWarningType()
        default: self.applyDefaultType()
        }
        
        self.delayTimer = delay
        
        self.notifyTitle = title
        self.tapToDismiss = dismissOnTap
        
        let containerFrame: CGRect = inView.frame
        self.bannerView = UIView()
        self.bannerView.backgroundColor = self.bannerBackgroundColor
        
        var calculationView: UITextView = UITextView()
        calculationView.attributedText = NSAttributedString(string: self.notifyTitle, attributes:
            [
                NSFontAttributeName: notifyTitleFont
            ])
        let size: CGSize = calculationView.sizeThatFits(
            CGSizeMake(containerFrame.width - 16, CGFloat(FLT_MAX)))
        var titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 16, size.height))
        titleView = applyTextViewStyle(titleView)
        self.bannerView.addSubview(titleView)
        self.bannerView.alpha = 0
        self.bannerView.frame = CGRectMake(0, -titleView.frame.size.height, containerFrame.width, titleView.frame.size.height)
        inView.addSubview(self.bannerView)
        
        if dismissOnTap == true {
            addTapToDismissGesture()
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bannerView.alpha = 1
            titleView.alpha = 1
            self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height + 5)
            }) { (Bool) -> Void in
                if self.bannerView != nil {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.bannerView.frame = CGRectMake(0, 0, containerFrame.width, titleView.frame.size.height)
                        }, completion: { (Bool) -> Void in
                            completionHandler()
                            if self.delayTimer > 0 {
                                UIView.animateWithDuration(self.delayTimer, animations: { () -> Void in
                                    if self.bannerView != nil {
                                        self.bannerView.alpha = 0.8
                                    }
                                    }, completion: { (cpl) -> Void in
                                        if cpl == true {
                                            self.dismissNotify()
                                        }
                                })
                            }
                    })
                }
        }
    }
    
    func dismissNotify() {
        if self.bannerView != nil {
            let curFrame = self.bannerView.frame
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.bannerView.alpha = 0
                self.bannerView.frame = CGRectMake(0, -curFrame.height, curFrame.width, curFrame.height)
            }, completion: { (cpl) -> Void in
                if (cpl == true) {
                    if self.bannerView != nil {
                        self.bannerView = nil
                    }
                }
            })
        }
    }
    
    func dismissNotify(completion: () -> Void) {
        if self.bannerView != nil {
            let curFrame = self.bannerView.frame
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.bannerView.alpha = 0
                self.bannerView.frame = CGRectMake(0, -curFrame.height, curFrame.width, curFrame.height)
                }, completion: { (cpl) -> Void in
                    if cpl == true {
                        if self.bannerView != nil {
                            self.bannerView = nil
                        }
                    }
                    completion()
            })
        }
    }
    
    func showCompletionHandler(completion: (Bool) -> Void) {
        
    }
    
    func addTapToDismissGesture() {
        if self.tapGesture != nil {
            self.tapGesture = nil
        }
        if tapToDismiss == true {
            self.tapGesture = UITapGestureRecognizer(target: self, action: "dismissNotify")
            self.bannerView.addGestureRecognizer(tapGesture!)
        }
    }
    
    // MARK: Banner Type
    func applyDefaultType() {
        notifyTitle = ""
        notifyTitleFont = UIFont.systemFontOfSize(17)
        bannerBackgroundColor = color(0x9E9E9E, alpha: 1.0)
        bannerForegroundColor = UIColor.whiteColor()
        delayTimer = 0
    }
    
    func applyDangerType() {
        notifyTitle = ""
        notifyTitleFont = UIFont.systemFontOfSize(17)
        bannerBackgroundColor = color(0xE53935, alpha: 1.0)
        bannerForegroundColor = UIColor.whiteColor()
        delayTimer = 0
    }
    
    func applyWarningType() {
        notifyTitle = ""
        notifyTitleFont = UIFont.systemFontOfSize(17)
        bannerBackgroundColor = color(0xFF8F00, alpha: 1.0)
        bannerForegroundColor = UIColor.whiteColor()
        delayTimer = 0
    }
    
    func applySuccessType() {
        notifyTitle = ""
        notifyTitleFont = UIFont.systemFontOfSize(17)
        bannerBackgroundColor = color(0x03A9F4, alpha: 1.0)
        bannerForegroundColor = UIColor.whiteColor()
        delayTimer = 0
    }
    
    func applyDisabledType() {
        notifyTitle = ""
        notifyTitleFont = UIFont.systemFontOfSize(17)
        bannerBackgroundColor = color(0x000000, alpha: 1.0)
        bannerForegroundColor = UIColor.whiteColor()
        delayTimer = 0
    }
    
    func color(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func applyTextViewStyle(textView: UITextView) -> UITextView {
        textView.text = self.notifyTitle
        textView.font = self.notifyTitleFont
        textView.alpha = 0
        textView.textColor = self.bannerForegroundColor
        textView.backgroundColor = UIColor.clearColor()
        textView.editable = false
        textView.selectable = false
        textView.scrollEnabled = false
        return textView
    }
   
}
