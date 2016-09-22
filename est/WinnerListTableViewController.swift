//
//  WinnerListTableViewController.swift
//  est
//
//  Created by Witsarut Suwanich on 9/20/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class WinnerListTableViewController: UITableViewController, TVCPopUpViewDelegate {
    
    let keychain = KeychainUtility.keychainUtilityInstance
    
    var winners = [Winner]()
    var estHTTPService = ESTHTTPService.estHTTPServiceInstance
    var headerHeight = CGFloat(0)
    
    var tvcPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerNib(UINib(nibName: "WinnerTableViewCell", bundle: nil), forCellReuseIdentifier: "winnerCell")
        self.tableView.registerNib(UINib(nibName: "WinnerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "winnerHeaderCell")
        self.tableView.registerNib(UINib(nibName: "WinnerSeperatorTableViewCell", bundle: nil), forCellReuseIdentifier: "winnerSeperatorCell")
        
        self.tableView.backgroundColor = EstColors.MAIN_BLUE_COLOR
        
        var logo = UIImageView(image: UIImage(named: "navbar_logo"))
        logo.frame = CGRectMake(0, 4, ((self.navigationController!.navigationBar.bounds.size.height - 8) * (3280/2679)), self.navigationController!.navigationBar.bounds.size.height - 8)
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = logo
        
        var menu = UIBarButtonItem(image: UIImage(named: "navbar_menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapMenuButton"))
        self.navigationItem.setLeftBarButtonItem(menu, animated: false)
        
        var notiIcon = self.keychain.getObject("notiicon")
        var noti = UIBarButtonItem(image: UIImage(named: "\(notiIcon)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapNotiButton"))
        self.navigationItem.setRightBarButtonItem(noti, animated: false)

        self.getWinnerList()
        
        self.tvcPopUpView.initTVCPopUpView(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-Announce")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tvcPopUp"), name: "tvcPopUp", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "tvcPopUp", object: nil)
        self.tapTVCPopUpCloseButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (self.winners.count > 0) {
            return 8
        } else {
            return 1
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("winnerHeaderCell", forIndexPath: indexPath) as! WinnerHeaderTableViewCell
            return cell
        } else if (indexPath.row % 2 == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("winnerCell", forIndexPath: indexPath) as! WinnerTableViewCell
            if (self.winners.count > 0) {
                var winner = self.winners[(indexPath.row / 2 )]
                cell.announceLabel.text = " ประกาศครั้งที่ \(winner.winner)"
                cell.dateLabel.text = " \(winner.date)"
                cell.prizeLabel.text = " จำนวน \(winner.prize) คัน"
                
                if (winner.status == "true") {
                    cell.announceImageView.image = UIImage(named: "alert_red")
                    var title = EstUILabelRedStroke(frame: cell.announceLabel.frame)
                    title.text = " ประกาศครั้งที่ \(winner.winner)"
                    title.font = cell.announceLabel.font
                    cell.addSubview(title)
                    cell.announceLabel.hidden = true
                } else {
                    cell.announceLabel.hidden = false
                    cell.announceImageView.image = UIImage(named: "alert_black")
                }
                
                cell.dateLabel.sizeToFit()
                cell.setNeedsUpdateConstraints()
                cell.setNeedsDisplay()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("winnerSeperatorCell", forIndexPath: indexPath) as! WinnerSeperatorTableViewCell
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row == 0) {
            self.headerHeight = (UIScreen.mainScreen().bounds.size.width * 624) / 1242
            return (UIScreen.mainScreen().bounds.size.width * 624) / 1242
        } else if (indexPath.row % 2 == 1) {
            var size = UIScreen.mainScreen().bounds.size
            if (size.height / size.width < 1.5) {
                return 120
            } else {
                return 75
            }
        } else {
            return 17
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row % 2 == 1) {
            if (self.winners.count > 0) {
                var winner = self.winners[(indexPath.row / 2 )]
                var url = NSURL(string: winner.url)
                UIApplication.sharedApplication().openURL(url!)
            }
        }
    }
    
    func tapMenuButton() {
        var scnc = self.navigationController as! HomeNavigationController
        scnc.drawer.open()
    }
    
    func tapNotiButton() {
    }
    
    // MARK: - winner list
    
    func getWinnerList() {
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        var request = estHTTPService.getWinnerList(Callback() { (winners, success, errorString, error) in
            if (success) {
                if let wnrs = winners {
                    self.winners = wnrs
                    self.setIsOpenWinnerList()
                    self.tableView.reloadData()
                }
            } else {
                // error
            }
        })
    }
    
    func setIsOpenWinnerList() {
        for var i = self.winners.count - 1; i >= 0; i-- {
            if (self.winners[i].status == "true") {
                self.keychain.setObject("is_open_winner_list_\(self.winners[i].winner)", value: "true")
            }
        }
    }
    
    func tvcPopUp() {
        self.tvcPopUpView.initTVCPopUpView(self)
        self.navigationController?.view.addSubview(self.tvcPopUpView)
    }
    
    func tapTVCPopUpCloseButton() {
        self.tvcPopUpView.tvcPopUpView.webView.loadHTMLString(nil, baseURL: nil)
        self.tvcPopUpView.removeFromSuperview()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
