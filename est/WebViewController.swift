//
//  WebViewController.swift
//  EST
//
//  Created by meow kling :3 on 9/2/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, TVCPopUpViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    let controllerManager = ControllerManager.controllerManagerInstance
    let keychain = KeychainUtility.keychainUtilityInstance
    
    var url: String?
    
    var tvcPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(animated: Bool) {
       self.loadBlackScreen()
    }
    
    func loadBlackScreen() {
        let requestURL = NSURL(string: "about:blank")
        self.webView.loadHTMLString("<body style='background-color:#000000;'></body>", baseURL: requestURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadBlackScreen()
        var logo = UIImageView(image: UIImage(named: "navbar_logo"))
        logo.frame = CGRectMake(0, 4, ((self.navigationController!.navigationBar.bounds.size.height - 8) * (3280/2679)), self.navigationController!.navigationBar.bounds.size.height - 8)
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = logo
        
        var menu = UIBarButtonItem(image: UIImage(named: "navbar_menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapMenuButton"))
        self.navigationItem.setLeftBarButtonItem(menu, animated: false)
       
        var notiIcon = self.keychain.getObject("notiicon")
        
        var noti_button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        noti_button.setImage(UIImage(named: "\(notiIcon)"), forState: UIControlState.Normal)
        noti_button.addTarget(self, action: Selector("tapNotiButton"), forControlEvents: UIControlEvents.TouchUpInside )
        noti_button.frame = CGRectMake(0,0,29,25)
        var noti_barButton = UIBarButtonItem(customView: noti_button)
        self.navigationItem.setRightBarButtonItem(noti_barButton, animated: false)
        
        self.tvcPopUpView.initTVCPopUpView(self)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
        self.webView.scrollView.bounces = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let url = self.url {
            let requestURL = NSURL(string: url)
            let request = NSURLRequest(URL: requestURL!)
            self.webView.loadRequest(request)
        }
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
    
    func tapMenuButton() {
        var scnc = self.navigationController as! HomeNavigationController
        scnc.drawer.open()
    }
    
    func tapNotiButton() {
        self.controllerManager.loadWinnerList()
    }
    
    func tapProfileButton() {
    }
    
    func reloadWebView() {
        if let url = self.url {
            let requestURL = NSURL(string: url)
            let request = NSURLRequest(URL: requestURL!)
            self.webView.loadRequest(request)
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
