//
//  ControllerManager.swift
//  EST
//
//  Created by Witsarut Suwanich on 8/19/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class ControllerManager {
    
    var drawerTableViewController: DrawerTableViewController?
    
    // MARK: - sendcode
    
//    var homeViewController: HomeViewController?
    var homeTableViewController: HomeTableViewController?
    var sendCodeTableViewController: SendCodeTableViewController?
    var checkPrizeTableViewController: CheckPrizeTableViewController?
    var webViewController: WebViewController?
    var winnerListTableViewController: WinnerListTableViewController?
    
    var homeNavigationController: HomeNavigationController?
    var sendCodeNavigationController: HomeNavigationController?
    var checkPrizeNavigationController: HomeNavigationController?
    var winnerListNavigationController: HomeNavigationController?
    var webNavigationController: HomeNavigationController?
    
    // MARK: - unexpected button
    
    class var controllerManagerInstance: ControllerManager {
        struct Static {
            static let instance: ControllerManager = ControllerManager()
        }
        return Static.instance
    }
    
    func getDrawerTableViewController() -> DrawerTableViewController {
        if (self.drawerTableViewController == nil) {
            self.drawerTableViewController = DrawerTableViewController(nibName: "DrawerTableViewController", bundle: nil)
        }
        return self.drawerTableViewController!
    }
    
//    func getHomeViewController() -> HomeViewController {
//        if (self.homeViewController == nil) {
//            self.homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        }
//        return self.homeViewController!
//    }
//    
//    func getHomeNavigationController() -> HomeNavigationController {
//        if (self.homeNavigationController == nil) {
//            self.homeNavigationController = HomeNavigationController(navigationBarClass: EstColarNavigationBar.self, toolbarClass: nil)
//            self.homeNavigationController?.viewControllers = [self.getHomeViewController()]
//            self.homeNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
//        }
//        return self.homeNavigationController!
//    }
    
    
    func getHomeTableViewController() -> HomeTableViewController    {
        if(self.homeTableViewController == nil) {
            self.homeTableViewController = HomeTableViewController(nibName: "HomeTableViewController", bundle: nil)
        }
        return self.homeTableViewController!
    }
    
    func getHomeNavigationController() -> HomeNavigationController  {
        if(self.homeNavigationController == nil)   {
            self.homeNavigationController = HomeNavigationController(navigationBarClass: EstColarNavigationBar.self, toolbarClass: nil)
            self.homeNavigationController?.viewControllers = [self.getHomeTableViewController()]
            self.homeNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        return self.homeNavigationController!
    }
    
    func getSendCodeTableViewController() -> SendCodeTableViewController {
        if (self.sendCodeTableViewController == nil) {
            self.sendCodeTableViewController = SendCodeTableViewController(nibName: "SendCodeTableViewController", bundle: nil)
        }
        return self.sendCodeTableViewController!
    }
    
    func getSendCodeNavigationController() -> HomeNavigationController {
        if (self.sendCodeNavigationController == nil) {
            self.sendCodeNavigationController = HomeNavigationController(navigationBarClass: EstColarNavigationBar.self, toolbarClass: nil)
            self.sendCodeNavigationController?.viewControllers = [self.getSendCodeTableViewController()]
            self.sendCodeNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        return self.sendCodeNavigationController!
    }
    
    func getCheckPrizeTableViewController() -> CheckPrizeTableViewController {
        /*if (self.checkPrizeTableViewController == nil) {
            self.checkPrizeTableViewController = CheckPrizeTableViewController(nibName: "CheckPrizeTableViewController", bundle: nil)
        }
        return self.checkPrizeTableViewController!*/
        self.checkPrizeTableViewController = CheckPrizeTableViewController(nibName: "CheckPrizeTableViewController", bundle: nil)
        return self.checkPrizeTableViewController!
    }
    
    func getCheckPrizeNavigationController() -> HomeNavigationController {
        if (self.checkPrizeNavigationController == nil) {
            self.checkPrizeNavigationController = HomeNavigationController(rootViewController: self.getCheckPrizeTableViewController())
            self.checkPrizeNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        return self.checkPrizeNavigationController!
    }
    
    func getWebViewController() -> WebViewController {
        if (self.webViewController == nil) {
            self.webViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        }
        return self.webViewController!
    }
    
    func getWebNavigationController() -> HomeNavigationController {
        if (self.webNavigationController == nil) {
            self.webNavigationController = HomeNavigationController(rootViewController: self.getWebViewController())
            self.webNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        return self.webNavigationController!
    }
    
    func getWebViewController(type: Int) -> WebViewController {
        if (self.webViewController == nil) {
            self.webViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        }
        return self.webViewController!
    }
    
    func getWebNavigationController(type: Int) -> HomeNavigationController {
        if (self.webNavigationController == nil) {
            self.webNavigationController = HomeNavigationController(rootViewController: self.getWebViewController())
            self.webNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        return self.webNavigationController!
    }
    
    func getWebViewController(url: String) -> WebViewController {
        if (self.webViewController == nil) {
            self.webViewController = WebViewController(nibName: "WebViewController", bundle: nil)
            self.webViewController?.url = url
        }
        return self.webViewController!
    }
    
    func getWebNavigationController(url: String) -> HomeNavigationController {
        if (self.webNavigationController == nil) {
            self.webNavigationController = HomeNavigationController(rootViewController: self.getWebViewController(url))
            self.webNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        self.webViewController?.url = url
        return self.webNavigationController!
    }
    
    func getWinnerListTableViewController() -> WinnerListTableViewController {
        if (self.winnerListTableViewController == nil) {
            self.winnerListTableViewController = WinnerListTableViewController(nibName: "WinnerListTableViewController", bundle: nil)
        }
        return self.winnerListTableViewController!
    }
    
    func getWinnerListNavigationController() -> HomeNavigationController {
        if (self.winnerListNavigationController == nil) {
            self.winnerListNavigationController = HomeNavigationController(rootViewController: self.getWinnerListTableViewController())
            self.winnerListNavigationController?.navigationItem.titleView = UIImageView(image: UIImage(named: "navbar_logo"))
        }
        return self.winnerListNavigationController!
    }
    
    // MARK: - load winner list
    
    func loadWinnerList() {
        
        var kc = KeychainUtility.keychainUtilityInstance
        var announce = kc.getObject("announce")
        
        
        println("announce : \(announce)")
        
        if(announce != "0") {
            kc.setObject("is_open_winner_list_\(announce)", value: "true")
            kc.setObject("notiicon", value: "noti_black_\(announce)")
        }else   {
            kc.setObject("notiicon", value: "noti_icon")
            
        }
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawer.replaceCenterViewControllerWithViewControllerWithoutAnimate(self.getCheckPrizeNavigationController())
    }
    
    func loadTVC() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawer.close()
    }
    
}
