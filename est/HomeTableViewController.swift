//
//  HomeTableViewController.swift
//  
//
//  Created by Apiwat Srisirisitthikul on 2/19/2559 BE.
//
//

import UIKit

class HomeTableViewController: UITableViewController, SendCodeButtonTableViewCellDelegate,TVCPopUpViewDelegate {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let controllerManager = ControllerManager.controllerManagerInstance
    let keychain = KeychainUtility.keychainUtilityInstance
    
   var estHTTPService = ESTHTTPService.estHTTPServiceInstance
    var row = 1
    var imageview_background: UIImageView!
    var view_background: UIView!
    
    
    let size = UIScreen.mainScreen().bounds.size
    let ratio = UIScreen.mainScreen().bounds.height / UIScreen.mainScreen().bounds.width
    
    var estPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    var tvcPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Home TableViewController")
        var size = UIScreen.mainScreen().bounds.size
        var ratio = size.height / size.width
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //self.imageView_background = UIImageView(frame: CGRectMake(0.0, 44.0, size.width, size.width * 1777/1080))
        //self.imageView_background.image = UIImage(named: "index_bg")
        
        //self.tableView.addSubview(self.imageView_background)
        //self.tableView.sendSubviewToBack(self.imageView_background)

        
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.backgroundColor = EstColors.MAIN_BLUE_COLOR
        //self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        
        var menu = UIBarButtonItem(image: UIImage(named: "navbar_menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapMenuButton"))
        self.navigationItem.setLeftBarButtonItem(menu, animated: false)
        
        
        
        var logo = UIImageView(image: UIImage(named: "navbar_logo_1"))
        logo.frame = CGRectMake(0, 4, ((self.navigationController!.navigationBar.bounds.size.height - 2) * (176/153)), self.navigationController!.navigationBar.bounds.size.height - 2)
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = logo
        
        self.tvcPopUpView.initTVCPopUpView(self)
        
    }

    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tvcPopUp"), name: "tvcPopUp", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("updateNotiIcon:"), name: "updatenotiicon", object: nil)
        
        var notiIcon = self.keychain.getObject("notiicon")
        println("Notiicon home  : \(notiIcon)")
        var noti_button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        noti_button.setImage(UIImage(named: "\(notiIcon)"), forState: UIControlState.Normal)
        noti_button.addTarget(self, action: Selector("tapNotiButton"), forControlEvents: UIControlEvents.TouchUpInside )
        noti_button.frame = CGRectMake(0,0,29,25)
        var noti_barButton = UIBarButtonItem(customView: noti_button)
        self.navigationItem.setRightBarButtonItem(noti_barButton, animated: false)

        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "tvcPopUp", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "updatenotiicon", object: nil)
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
        return self.row
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as! HomeTableViewCell
        var size = UIScreen.mainScreen().bounds.size
        var ratio = size.height / size.width
        //var height = self.navigationController?.navigationBar.frame.height
        //println(height)
        
        
        // MARK : - Add Background image
//        self.tableView.rowHeight = CGFloat(size.width * 1777/1080)
        // w, w * h / w
        if(ratio == 1.5)    {
            // 3:2
//            self.imageview_background = UIImageView(frame: CGRectMake(0.0, 0.0, size.width, size.height))
//            self.view_background = UIView(frame: CGRectMake(0.0, 0.0, size.width, size.height))
            self.imageview_background = UIImageView(frame: CGRectMake(0.0, 0.0, size.width, (size.width * (889/640))))
            self.view_background = UIView(frame: CGRectMake(0.0, 0.0, size.width, (size.width * (889/640))))
            self.imageview_background.image = UIImage(named: "index_bg_for_iPhone4")
        }else if(ratio < 1.5)  {
//            // 4:3
            self.imageview_background = UIImageView(frame: CGRectMake(0.0, 0.0, size.width + 20 , ((size.width + 20) * (960/768))))
            self.view_background = UIView(frame: CGRectMake(0.0, 0.0, size.width + 20, ((size.width + 20) * (960/768))))
            self.imageview_background.image = UIImage(named: "index_bg")
        }else   {
//            // 16:9
            self.imageview_background = UIImageView(frame: CGRectMake(0.0, 0.0, size.width,( size.width * 1772/1080 )))
            self.view_background = UIView(frame: CGRectMake(0.0, 0.0, size.width,( size.width * 1772/1080 )))
            self.imageview_background.image = UIImage(named: "index_bg")
        }
//        self.imageView_background = UIImageView(frame: CGRectMake(0.0, 0.0, size.width,( size.width * 1777/1080 )))
//        self.view_background = UIView(frame: CGRectMake(0.0, 0.0, size.width,( size.width * 1777/1080 )))
        self.imageview_background.autoresizesSubviews = false
//
        self.view_background.contentMode = UIViewContentMode.TopLeft
        self.view_background.autoresizesSubviews = false
        self.view_background.addSubview(self.imageview_background)
        cell.backgroundView?.contentMode = UIViewContentMode.TopLeft
//        cell.backgroundView = view_background
        cell.addSubview(imageview_background)
        cell.sendSubviewToBack(imageview_background)
        cell.delegate = self
//        cell.button_sendcode.setImage(UIImage(named: "bt_sendcode_3"), forState: UIControlState.Normal)
        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(self.ratio == 1.5)    {
            // 3:2
            return UIScreen.mainScreen().bounds.size.width * (889/640)
        }else if(self.ratio < 1.5)  {
            // 4:3
            return UIScreen.mainScreen().bounds.size.width * (960/768)
        }else   {
            // 16:9
            return UIScreen.mainScreen().bounds.size.width * (1772/1080)
        }
    }
   
    // MARK: - navbar Delegate
    func tapMenuButton()    {
        println("tappMenuButton")
        
        var scnc = self.navigationController as! HomeNavigationController
        scnc.drawer.open()
        
        self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Click_menu")
    }
    
    func tapNotiButton()    {
        println("tapNotiButton")
        self.controllerManager.loadWinnerList()
        self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "BT_announce")
    }
    // MARK: - cell Delegate
    func tapSendCodeButton()    {
       println("TapSendCodeButton")
        self.estHTTPService.sendStartSendCodeState()
        self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Home_sendcode")
       self.appDelegate.loadSendCodeMainController()
    }
    
    func tvcPopUp() {
        self.tvcPopUpView.initTVCPopUpView(self)
        self.navigationController?.view.addSubview(self.tvcPopUpView)
    }
    
    func tapTVCPopUpCloseButton() {
        self.tvcPopUpView.tvcPopUpView.webView.loadHTMLString(nil, baseURL: nil)
        self.tvcPopUpView.removeFromSuperview()
    }
    
    func updateNotiIcon(notification: NSNotification) {
        //
        var notiIcon = self.keychain.getObject("notiicon")
        println("Notiicon home  : \(notiIcon)")
        var noti_button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        noti_button.setImage(UIImage(named: "\(notiIcon)"), forState: UIControlState.Normal)
        noti_button.addTarget(self, action: Selector("tapNotiButton"), forControlEvents: UIControlEvents.TouchUpInside )
        noti_button.frame = CGRectMake(0,0,29,25)
        var noti_barButton = UIBarButtonItem(customView: noti_button)
        self.navigationItem.setRightBarButtonItem(noti_barButton, animated: false)
    }
}
