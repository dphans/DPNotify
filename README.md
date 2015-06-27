# DPNotify
DPNotify used to send short notifications on screen simple &amp; quickly for iOS developing using Swift.

# Preview
![alt tag](https://github.com/dphans/DPNotify/blob/master/demo.gif)

# Features
- block syntax.
- delay timer.
- 5 notify styles available (Default, Danger, Warning, Success, Disabled).
- customize font & color.
- tap to dismiss message.
- request more? please contact me (my email below)

# Installation
Just add file named DPNotify.swift to your project.

# Examples

- Show notify in self.view:
``` swift
DPNotify.sharedNotify.showNotifyInView(view, title: "Awesome :P", dismissOnTap: true, notifyType: .DEFAULT)
```

- Completion handler:
``` swift
DPNotify.sharedNotify.showNotifyInView(view,
                title: items[indexPath.row],
                dismissOnTap: true,
                notifyType: .DANGER,
                delay: 0,
                completionHandler: { () -> Void in
                    var alert = UIAlertView(
                        title: "Completed!",
                        message: "Notify showed!",
                        delegate: nil,
                        cancelButtonTitle: "Hit ;-)")
                    alert.show()
                })
```

- Dismiss message:
``` swift
DPNotify.sharedNotify.dismissNotify()
```
``` swift
DPNotify.sharedNotify.dismissNotify({ () -> Void in
                var alert = UIAlertView(title: "Completed!", message: "Notify dismissed!", delegate: nil, cancelButtonTitle: "はい！")
                alert.show()
```

- Custom style:
``` swfit
DPNotify.sharedNotify.bannerForegroundColor = DPNotify.sharedNotify.color(0x607D8B, alpha: 1)
DPNotify.sharedNotify.bannerBackgroundColor = UIColor(white: 0.8, alpha: 0.8)
DPNotify.sharedNotify.notifyTitleFont = UIFont(name: "Avenir", size: 17.0)
DPNotify.sharedNotify.showNotifyInView(view, title: "Hello, Dino Phan :D", dismissOnTap: true)
```

# Contact:
Homepage: http://www.dinophan.com - Email: baophan94@icloud.com
