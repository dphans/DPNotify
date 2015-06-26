//
//  TableViewController.swift
//  DemoDPNotify
//
//  Created by @baophan94 on 6/26/15.
//  Copyright (c) 2015 @baophan94. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items: Array<String> = [
        "Normal",
        "Danger",
        "Warning",
        "Success",
        "No connection, please check network connection and try again again again. bla bla ;-)",
        "Show with completion handler",
        "Dismiss",
        "Dismiss with completion handler",
        "Show success delay: 1 second",
        "Custom banner"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        let bgStdView = UIView()
        bgStdView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        cell.selectedBackgroundView = bgStdView
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
            case 0: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true, notifyType: .DEFAULT)
            case 1: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true, notifyType: .DANGER)
            case 2: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true, notifyType: .WARNING)
            case 3: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true, notifyType: .SUCCESS)
            case 4: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true, notifyType: .DISABLED)
        case 5: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true, notifyType: .DANGER, delay: 0, completionHandler: { () -> Void in
            var alert = UIAlertView(title: "Completed!", message: "Notify showed!", delegate: nil, cancelButtonTitle: "はい！")
            alert.show()
        })
            case 6: DPNotify.sharedNotify.dismissNotify()
            case 7: DPNotify.sharedNotify.dismissNotify({ () -> Void in
                var alert = UIAlertView(title: "Completed!", message: "Notify dismissed!", delegate: nil, cancelButtonTitle: "はい！")
                alert.show()
            })
            case 8: DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: false, notifyType: .SUCCESS, delay: 1.0)
        case 9:
            DPNotify.sharedNotify.bannerForegroundColor = DPNotify.sharedNotify.color(0x607D8B, alpha: 1)
            DPNotify.sharedNotify.bannerBackgroundColor = UIColor(white: 0.8, alpha: 0.8)
            DPNotify.sharedNotify.notifyTitleFont = UIFont(name: "Avenir", size: 17.0)
            DPNotify.sharedNotify.showNotifyInView(view, title: items[indexPath.row], dismissOnTap: true)
            default: break
        }
    }

}
