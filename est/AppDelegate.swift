//
//  AppDelegate.swift
//  est
//
//  Created by Witsarut Suwanich on 9/20/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var controllerManager = ControllerManager.controllerManagerInstance
    
    var drawer: ICSDrawerController!
    var user: User?
    
    var estHTTPService = ESTHTTPService.estHTTPServiceInstance
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        EstApplication.getNotiIconImage()
        EstApplication.getNoti()
        EstApplication.setAppData()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.loadHomeViewController()
//        self.loadSendCodeMainController()
        
        Parse.setApplicationId("5wYuflCCq3BDdVDta6A3VeIihJt53UNlZsIYo3Mh",
            clientKey: "WnmpSdWxDnIwWkNUzsUK2MoOBzh3jLph71S2QmtU")
        
        // Register for Push Notitications
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
            application.registerForRemoteNotificationTypes(types)
        }
        
        
//        AppsFlyerTracker.sharedTracker().appsFlyerDevKey = "vdVe9UxXnHjhUoKFT2HAnK"
//        AppsFlyerTracker.sharedTracker().appleAppID = "1033833972"
        
        // Configure tracker from GoogleService-Info.plist.
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // Optional: configure GAI options.
        var gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        /*ICSColorsViewController *colorsVC = [[ICSColorsViewController alloc] initWithColors:colors];
        ICSPlainColorViewController *plainColorVC = [[ICSPlainColorViewController alloc] init];
        plainColorVC.view.backgroundColor = colors[0];
        
        ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:colorsVC
        centerViewController:plainColorVC];
        
        self.window.rootViewController = drawer;
        [self.window makeKeyAndVisible];*/
        
        // return true
        
        self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-HomeLogo")
        self.estHTTPService.sendOpenAppSendCodeState()
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        AppsFlyerTracker.sharedTracker().trackAppLaunch()
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        NSLog("deviceToken x%@", deviceToken)
        let installation = PFInstallation.currentInstallation()
        
        installation.addUniqueObject("DevFuck", forKey: "channels")
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            println("Push notifications are not supported in the iOS Simulator.")
        } else {
            println("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
        
        var state = application.applicationState
        if (state == UIApplicationState.Active) {
            self.drawer.replaceCenterViewControllerWithViewControllerWithoutAnimate(ControllerManager.controllerManagerInstance.getCheckPrizeTableViewController())
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("pushNotification", object: nil, userInfo: userInfo)
        }
    }
    
    func loadHomeViewController() {
        var drawerVC = DrawerTableViewController(nibName: "DrawerTableViewController", bundle: nil)
        drawerVC.setHomeMenu()
        var homeVC = self.controllerManager.getHomeNavigationController()
        self.drawer = ICSDrawerController(leftViewController: drawerVC, centerViewController: homeVC)
        self.window?.rootViewController = drawer
        self.window?.makeKeyAndVisible()
    }
    
    func loadSendCodeMainController() {
        var drawerVC = DrawerTableViewController(nibName: "DrawerTableViewController", bundle: nil)
        drawerVC.setSendCodeMenu()
        var sendCode = self.controllerManager.getSendCodeNavigationController()
        self.drawer = ICSDrawerController(leftViewController: drawerVC, centerViewController: sendCode)
        self.window?.rootViewController = drawer
        self.window?.makeKeyAndVisible()
    }
    
}
