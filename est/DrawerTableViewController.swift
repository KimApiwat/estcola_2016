//
//  DrawerTableViewController.swift
//  EST
//
//  Created by meow kling :3 on 8/27/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class DrawerTableViewController: UITableViewController {
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var controllerManager = ControllerManager.controllerManagerInstance
    var estHTTPService = ESTHTTPService.estHTTPServiceInstance
    let keychain = KeychainUtility.keychainUtilityInstance
    
    var icons = [String]()
    var menu = [String]()
    
    var selectedMenu = ""
    
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
        
        self.tableView.registerNib(UINib(nibName: "DrawerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerHeaderCell")
        self.tableView.registerNib(UINib(nibName: "DrawerTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerCell")
        self.tableView.registerNib(UINib(nibName: "DrawerSeperatorTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerSeperatorCell")
        
        // var bg = UIImageView(image: UIImage(named: "drawer_bg"))
//        bg.contentMode = UIViewContentMode.Left
        
        self.view.layer.shadowOffset = CGSizeZero
        self.view.layer.shadowOpacity = 1.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (section == 0) {
            return 1
        } else {
            return self.menu.count * 2
        }
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("drawerHeaderCell", forIndexPath: indexPath) as! DrawerHeaderTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            if (self.selectedMenu == "sendcode") {
                cell.headerImageView.image = UIImage(named: "drawer_header")
            } else {
                cell.headerImageView.image = nil
            }
            return cell
        } else {
            if (indexPath.row % 2 == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("drawerCell", forIndexPath: indexPath) as! DrawerTableViewCell
                cell.drawerNameLabel.text = self.menu[indexPath.row/2]
                cell.drawerIcon.image = UIImage(named: "\(self.icons[indexPath.row/2])_icon")
                cell.backgroundColor = UIColor.clearColor()
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("drawerSeperatorCell", forIndexPath: indexPath) as! DrawerSeperatorTableViewCell
                if (self.selectedMenu == "sendcode") {
                    cell.seperatorImageView.image = UIImage(named: "seperator")
                } else {
                }
                cell.backgroundColor = UIColor.clearColor()
                return cell
            }
        }

    }
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == 0)  {
            let cell = tableView.dequeueReusableCellWithIdentifier("drawerHeaderCell", forIndexPath: indexPath) as! DrawerHeaderTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            if(self.selectedMenu == "sendcode") {
                //cell.imageView_Header.image = UIImage(named: "navbar_logo")
            }else   {
                //cell.imageView_Header.image = nil
            }
            //cell.imageView_Header = nil
            return cell
        }else{
            if(indexPath.row % 2 == 0)  {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("drawerCell", forIndexPath: indexPath) as! DrawerTableViewCell
                cell.drawerNameLabel.text = self.menu[indexPath.row/2]
                cell.drawerIcon.image = UIImage(named: "\(self.icons[indexPath.row/2])_icon")
                cell.backgroundColor = UIColor.clearColor()
                return cell
                
            }else   {
                let cell = tableView.dequeueReusableCellWithIdentifier("drawerSeperatorCell", forIndexPath: indexPath) as! DrawerSeperatorTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.backgroundColor = UIColor.clearColor()
                return cell
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 135
        } else {
            if (indexPath.row % 2 == 0) {
                return 42
            } else {
                return 10
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        if (indexPath.section == 1) {
            if (indexPath.row / 2 == 0) {
                self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-Submit")
                self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Menu_sendcode")
                if(self.appDelegate.drawer.centerViewController != self.controllerManager.getSendCodeNavigationController()) {
                    self.appDelegate.drawer.replaceCenterViewControllerWithViewController(self.controllerManager.getSendCodeNavigationController())
                }else   {
                    self.appDelegate.drawer.close()
                }
            } else if (indexPath.row / 2 == 1) {
                self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Menu_rule")
                self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-Rule")
                if (self.appDelegate.drawer.centerViewController != self.controllerManager.getWebNavigationController(0)) {
                    self.appDelegate.drawer.replaceCenterViewControllerWithViewController(self.controllerManager.getWebNavigationController(self.keychain.getObject("page_rule")))
                } else {
                    var cvc = self.appDelegate.drawer.centerViewController as! HomeNavigationController
                    var web = cvc.viewControllers[0] as! WebViewController
                    if (web.url != EstApplication.RULE_URL) {
                        self.appDelegate.drawer.replaceCenterViewControllerWithViewController(self.controllerManager.getWebNavigationController(self.keychain.getObject("page_rule")))
                        web.reloadWebView()
                        return
                    }
                    self.appDelegate.drawer.close()
                }           
            } else if (indexPath.row / 2 == 2) {
                self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-KeyVisual")
                self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Menu_how")
                if (self.appDelegate.drawer.centerViewController != self.controllerManager.getWebNavigationController(0)) {
                    self.appDelegate.drawer.replaceCenterViewControllerWithViewController(self.controllerManager.getWebNavigationController(self.keychain.getObject("page_how_to")))
                } else {
                    var cvc = self.appDelegate.drawer.centerViewController as! HomeNavigationController
                    var web = cvc.viewControllers[0] as! WebViewController
                    if (web.url != EstApplication.HOWTO_URL) {
                        self.appDelegate.drawer.replaceCenterViewControllerWithViewController(self.controllerManager.getWebNavigationController(self.keychain.getObject("page_how_to")))
                        web.reloadWebView()
                        return
                    }
                    self.appDelegate.drawer.close()
                }           
            } else if (indexPath.row / 2 == 3) {
                self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Menu_tvc")
                self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-TVC")
                self.appDelegate.drawer.close()
                NSNotificationCenter.defaultCenter().postNotificationName("tvcPopUp", object: nil)
            } else if (indexPath.row / 2 == 4) {
                self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Menu_checkwin")
                self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "setSendCode-Check")
                if (self.appDelegate.drawer.centerViewController != self.controllerManager.getCheckPrizeNavigationController()) {
                    self.appDelegate.drawer.replaceCenterViewControllerWithViewController(self.controllerManager.getCheckPrizeNavigationController())
                } else {
                    self.appDelegate.drawer.close()
                }
            } else if (indexPath.row / 2 == 5)  {
                self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Menu_Share")
                var content = FBSDKShareLinkContent()
                
                
                
                content.contentURL = NSURL(string: self.keychain.getObject("share_url"))
                content.contentTitle = self.keychain.getObject("share_title")
                content.contentDescription = self.keychain.getObject("share_description")
                content.imageURL = NSURL(string: self.keychain.getObject("share_image"))
                
                
                
                FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
            }else if (indexPath.row / 2 == 6)   {
                self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-Menu")
                self.appDelegate.loadHomeViewController()
            }
        }
        
    }
    
    // MARK: - custom setup for sendcode & game
    
//    func setSendCodeMenu() {
////        self.icons = ["sendcode", "rule", "howto", "tvc", "winner", "share", "home"]
////        self.menu = ["ส่งรหัส", "ของรางวัลและเงื่อนไข", "ช่องทางการส่ง", "คลิปโฆษณา", "ตรวจสอบผู้โชคดี", "แชร์", "หน้าหลัก"]
//        self.icons = ["sendcode", "rule", "howto", "tvc", "winner", "share"]
//        self.menu = ["ส่งรหัส", "ของรางวัลและเงื่อนไข", "ช่องทางการส่ง", "คลิปโฆษณา", "ตรวจสอบผู้โชคดี", "แชร์"]
//        self.selectedMenu = "sendcode"
//        
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navbar_bg"), forBarMetrics: UIBarMetrics.Default)
//        
//        self.tableView.backgroundView = UIImageView(image: UIImage(named: "drawer_bg"))
////        self.estHTTPService.sendEstThaiMobileTracker("Page", action: "opened", label: "estSendCode-Menu")
//    }
    
    
    func setSendCodeMenu()  {
        println("setSendCodeMenu")
        self.icons = ["sendcode", "rule", "howto", "tvc", "winner", "share", "home"]
        self.menu = ["ส่งรหัสที่นี่ !", "กติกาและเงื่อนไข", "ช่องทางการส่ง", "คลิปโฆษณา", "ประกาศผู้โชคดี", "แชร์", "หน้าหลัก"]
        self.selectedMenu = "sendcode"
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navbar_bg"), forBarMetrics: UIBarMetrics.Default)
        //        self.tableView.backgroundView = UIImageView(image: UIImage(named: "menu_bg"))
        
        var imageView_Background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.width * (1920/837)))
        var view_Background = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (1920/837)))
        imageView_Background.image = UIImage(named: "menu_bg")
        imageView_Background.autoresizesSubviews = false
        view_Background.contentMode = UIViewContentMode.TopLeft
        view_Background.autoresizesSubviews = false
        view_Background.addSubview(imageView_Background)
        self.tableView.backgroundView?.contentMode = UIViewContentMode.TopLeft
        self.tableView.backgroundView = view_Background
        
        
        println("check")
    }
    
//    func setUnexpectedButtonMenu() {
//        self.icons = ["home", "myprofile", "howto", "rule", "winner", "share"]
//        self.menu = ["หน้าหลัก", "My Profile", "วิธีการลุ้น", "ของรางวัลและเงื่อนไข", "ตรวจสอบสิทธิ์ลุ้น", "แชร์"]
//        self.selectedMenu = "unexpected"
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "game_navbar"), forBarMetrics: UIBarMetrics.Default)
//        
//        var backgroundView = UIImageView(frame: CGRectMake(0, 0, 250, UIScreen.mainScreen().bounds.size.height))
//        
//        var topView = UIImageView(frame: CGRectMake(0, 0, 250, 250 * 572 / 496))
//        topView.image = UIImage(named: "game_drawer_header")
//        
//        backgroundView.addSubview(topView)
//        backgroundView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
//        
//        /*var backgroundView = UIImageView(image: UIImage(named: "full_game_drawer"))
//        backgroundView.contentMode = UIViewContentMode.TopLeft*/
//        
//        self.tableView.backgroundView = backgroundView
////        self.estHTTPService.sendEstThaiMobileTracker("Page", action: "opened", label: "menu")
//    }
    
    func setHomeMenu()  {
        println("setHomeMenu")
        self.icons = ["sendcode", "rule", "howto", "tvc", "winner", "share", "home"]
        self.menu = ["ส่งรหัสที่นี่ !", "กติกาและเงื่อนไข", "ช่องทางการส่ง", "คลิปโฆษณา", "ประกาศผู้โชคดี", "แชร์", "หน้าหลัก"]
        self.selectedMenu = "home"
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navbar_bg"), forBarMetrics: UIBarMetrics.Default)
        //        self.tableView.backgroundView = UIImageView(image: UIImage(named: "menu_bg"))
        println("check homeMenu")
        
        var imageView_Background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width - 70, height: (UIScreen.mainScreen().bounds.size.width - 70) * (1920/837)))
        var view_Background = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width - 70, ( UIScreen.mainScreen().bounds.size.width - 70 ) * (1920/837)))
        imageView_Background.image = UIImage(named: "menu_bg")
        imageView_Background.autoresizesSubviews = false
        view_Background.contentMode = UIViewContentMode.TopLeft
        view_Background.autoresizesSubviews = false
        view_Background.addSubview(imageView_Background)
        self.tableView.backgroundView?.contentMode = UIViewContentMode.TopLeft
        self.tableView.backgroundView = view_Background
        
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
