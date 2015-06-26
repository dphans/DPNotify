//
//  DPNotify.swift
//  DemoDPNotify
//
//  Created by @baophan94 on 6/26/15.
//  Contact: www.dinophan.com - baophan94@icloud.com
//  Copyright (c) 2015 @baophan94. All rights reserved.
//

import UIKit

enum DPNOTIFYTYPE {
    case DEFAULT
    case DANGER
    case WARNING
    case SUCCESS
    case DISABLED
}

class DPNotify: NSObject {
    
    static let sharedNotify = DPNotify()
    
    // Customize banner
    var bannerBackgroundColor: UIColor!
    var bannerForegroundColor: UIColor!
    var tapToDismiss: Bool!
    var delayTimer: NSTimeInterval!
    var bannerType: DPNOTIFYTYPE!
    
    // Customize text
    var notifyTitle: String!
    var notifyTitleFont: UIFont!
    
    // DPNotify Banner
    var bannerView: UIView!
    var tapGesture: UITapGestureRecognizer?
    
    
    
    func showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        self.applyDefaultType()
        
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
            CGSizeMake(containerFrame.width - 48, CGFloat(FLT_MAX)))
        let titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 48, size.height))
        titleView.text = self.notifyTitle
        titleView.font = self.notifyTitleFont
        titleView.alpha = 0
        titleView.textColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.clearColor()
        titleView.editable = false
        titleView.selectable = false
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
    
    func showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNOTIFYTYPE) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        switch notifyType {
        case DPNOTIFYTYPE.DEFAULT: self.applyDefaultType()
        case DPNOTIFYTYPE.DANGER: self.applyDangerType()
        case DPNOTIFYTYPE.DISABLED: self.applyDisabledType()
        case DPNOTIFYTYPE.SUCCESS: self.applySuccessType()
        case DPNOTIFYTYPE.WARNING: self.applyWarningType()
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
            CGSizeMake(containerFrame.width - 48, CGFloat(FLT_MAX)))
        let titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 48, size.height))
        titleView.text = self.notifyTitle
        titleView.font = self.notifyTitleFont
        titleView.alpha = 0
        titleView.textColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.clearColor()
        titleView.editable = false
        titleView.selectable = false
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
                            
                    })
                }
        }
    }
    
    func showNotifyInView(inView: UIView, title: String, dismissOnTap: Bool, notifyType: DPNOTIFYTYPE, delay: NSTimeInterval) {
        
        if self.bannerView != nil {
            if self.tapGesture != nil {
                self.bannerView.removeGestureRecognizer(self.tapGesture!)
                self.tapGesture = nil
            }
            self.bannerView.removeFromSuperview()
            self.bannerView = nil
        }
        
        switch notifyType {
        case DPNOTIFYTYPE.DEFAULT: self.applyDefaultType()
        case DPNOTIFYTYPE.DANGER: self.applyDangerType()
        case DPNOTIFYTYPE.DISABLED: self.applyDisabledType()
        case DPNOTIFYTYPE.SUCCESS: self.applySuccessType()
        case DPNOTIFYTYPE.WARNING: self.applyWarningType()
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
            CGSizeMake(containerFrame.width - 48, CGFloat(FLT_MAX)))
        let titleView = UITextView(
            frame: CGRectMake(8, 0, containerFrame.width - 48, size.height))
        titleView.text = self.notifyTitle
        titleView.font = self.notifyTitleFont
        titleView.alpha = 0
        titleView.textColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.clearColor()
        titleView.editable = false
        titleView.selectable = false
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
                            UIView.animateWithDuration(self.delayTimer, animations: { () -> Void in
                                if self.bannerView != nil {
                                    self.bannerView.alpha = 0.8
                                }
                            }, completion: { (Bool) -> Void in
                                self.dismissNotify()
                            })
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
            }, completion: { (Bool) -> Void in
                if self.bannerView != nil {
                    self.bannerView = nil
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
                }, completion: { (Bool) -> Void in
                    if self.bannerView != nil {
                        self.bannerView = nil
                    }
                    completion()
            })
        }
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
   
}
