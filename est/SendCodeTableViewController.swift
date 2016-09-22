//
//  SendCodeTableViewController.swift
//  EST
//
//  Created by meow kling :3 on 8/27/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//



import UIKit

class SendCodeTableViewController: UITableViewController, AddMoreTableCellDelegate, SendButtonTableViewCellDelegate, EstPopUpDetailDelegate, PopUpFinishViewDelegate, UITextFieldDelegate, FBSDKSharingDelegate, TVCPopUpViewDelegate {
    
    let keychain = KeychainUtility.keychainUtilityInstance
    let controllerManager = ControllerManager.controllerManagerInstance
    var estHTTPService = ESTHTTPService.estHTTPServiceInstance
    
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width
    
    var estPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    var popUpFinishView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    var tvcPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    var row = 16
    var left = 0
    var codes = [Int: String]()
    var sendable = false
    var finish = false
    
    var error_sendcode = [String: Bool]()
    
    var sendable_codes = [Int: Bool]()
    
    var exist_code = [Int]()
    
    var activeTextField: UITextField?
    
    var notificationCenter = NSNotificationCenter.defaultCenter()
    
    var addMoreCell: AddMoreTableViewCell?
    
    var isAddMore = true
    
    var isWinner = false
    
    var timer = NSTimer()
    
    var mobileno = ""
    
    
    var alertmessage = false
    
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
        
        var tapReg = UITapGestureRecognizer(target: self, action: Selector("tapped"))
        self.view.addGestureRecognizer(tapReg)
        
        self.tableView.registerNib(UINib(nibName: "SendCodeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCodeHeaderCell")
        self.tableView.registerNib(UINib(nibName: "TelephoneTableViewCell", bundle: nil), forCellReuseIdentifier: "telCell")
        self.tableView.registerNib(UINib(nibName: "DetailTextTableViewCell", bundle: nil), forCellReuseIdentifier: "detailTextCell")
        self.tableView.registerNib(UINib(nibName: "CodeTableViewCell", bundle: nil), forCellReuseIdentifier: "codeCell")
        self.tableView.registerNib(UINib(nibName: "AddMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "addMoreCell")
        self.tableView.registerNib(UINib(nibName: "SendButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "sendButtonCell")
        self.tableView.registerNib(UINib(nibName: "SendCodeFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCodeFooterCell")
        self.tableView.registerNib(UINib(nibName: "SendCodeAlertTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCodeAlertCell")
        
        self.tableView.backgroundColor = EstColors.MAIN_BLUE_COLOR
        
        var bgImage = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (3118/1080)))
        var bg = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (3118/1080)))
        bgImage.image = UIImage(named: "sendcode_bg")
        bgImage.autoresizesSubviews = false
        bg.contentMode = UIViewContentMode.TopLeft
        bg.autoresizesSubviews = false
        bg.addSubview(bgImage)
//        bgImage.contentMode = UIViewContentMode.ScaleAspectFill
//        bgImage.clipsToBounds = true
        self.tableView.backgroundView?.contentMode = UIViewContentMode.TopLeft
        self.tableView.backgroundView = bg
        
        var logo = UIImageView(image: UIImage(named: "navbar_logo_1"))
        logo.frame = CGRectMake(0, 4, ((self.navigationController!.navigationBar.bounds.size.height - 8) * (176/153)), self.navigationController!.navigationBar.bounds.size.height - 8)
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = logo
        
        var menu = UIBarButtonItem(image: UIImage(named: "navbar_menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapMenuButton"))
        self.navigationItem.setLeftBarButtonItem(menu, animated: false)

        var notiIcon = self.keychain.getObject("notiicon")
        
        println("noti icon send code: \(notiIcon)")
        var noti_button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        noti_button.setImage(UIImage(named: "\(notiIcon)"), forState: UIControlState.Normal)
        noti_button.addTarget(self, action: Selector("tapNotiButton"), forControlEvents: UIControlEvents.TouchUpInside )
        noti_button.frame = CGRectMake(0,0,29,25)
        var noti_barButton = UIBarButtonItem(customView: noti_button)
        self.navigationItem.setRightBarButtonItem(noti_barButton, animated: false)
        
        
        
        
        
        self.popUpFinishView.initEstPopUpFinishView(self)
        self.tvcPopUpView.initTVCPopUpView(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationCenter.addObserver(self, selector: Selector("keyboardWillBeHidden"), name: UIKeyboardWillHideNotification, object: nil)
        
        if (self.keychain.getObject("mobile") != "") {
            self.checkValidPhoneNumber(self.keychain.getObject("mobile"))
        }else   {
            self.mobileno = ""
            self.tableView.reloadData()
        }
//        self.checkDailyQuota()
        self.checkActiveApp()
        
        self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-Submit")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("pushNotification"), name: "pushNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tvcPopUp"), name: "tvcPopUp", object: nil)
        
        var kc = KeychainUtility.keychainUtilityInstance
        var notiIcon = kc.getObject("notiicon")
        println("---------------------------------")
        println("noti icon send code: \(notiIcon)")

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "pushNotification", object: nil)
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
        return self.row
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("sendCodeHeaderCell", forIndexPath: indexPath) as! SendCodeHeaderTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell           
        } else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailTextCell", forIndexPath: indexPath) as! DetailTextTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell           
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("telCell", forIndexPath: indexPath) as! TelephoneTableViewCell
            cell.telTextField.delegate = self
            cell.telTextField.tag = 99
            if (self.keychain.getObject("mobile") != "") {
                cell.telTextField.text = self.keychain.getObject("mobile")
                self.sendable = true
                cell.imageview_signcorrect.hidden = false
                
            }else   {
                cell.imageview_signcorrect.hidden = true
                self.sendable = false
                cell.telTextField.text = self.mobileno
            }
            
            if(self.finish) {
                
                cell.telTextField.text == ""
                cell.telTextField.enabled = false
                cell.contentView.alpha = 0.4
            }else   {
                cell.telTextField.enabled = true
            }
            
            cell.backgroundColor = UIColor.clearColor()
            return cell
        } else if (indexPath.row == self.row - 3) {
            let cell = tableView.dequeueReusableCellWithIdentifier("sendCodeAlertCell", forIndexPath: indexPath) as! SendCodeAlertTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            
            if(alertmessage)    {
                cell.contentView.hidden = false
            }else   {
                cell.contentView.hidden = true
            }
            
            return cell
        } else if (indexPath.row == self.row - 2) {
            let cell = tableView.dequeueReusableCellWithIdentifier("sendButtonCell", forIndexPath: indexPath) as! SendButtonTableViewCell
            cell.delegate = self
            if (self.sendable) {
                cell.sendButton.enabled = true
            } else {
                cell.sendButton.enabled = false
            }
            cell.backgroundColor = UIColor.clearColor()
            return cell                      
        } else if (indexPath.row == self.row - 1)    {
            let cell = tableView.dequeueReusableCellWithIdentifier("sendCodeFooterCell", forIndexPath: indexPath) as! SendCodeFooterTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("codeCell", forIndexPath: indexPath) as! CodeTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            cell.codeTextField.delegate = self
//            cell.codeTextField.tag = 1
            println("4578900987653127301273917238912")
            cell.codeIcon.image = UIImage(named: "code_bg")
            cell.codeNumber.hidden = false
            cell.codeNumber.text = "\(indexPath.row - 2)"
            cell.codeTextField.tag = String("\(indexPath.row - 2)").toInt()!
            
            println("tag text field : \(cell.codeTextField.tag)")
            
            if(self.codes[cell.codeTextField.tag] != nil)   {
                cell.codeTextField.text = self.codes[cell.codeTextField.tag]
            }else   {
                cell.codeTextField.text = ""
            }
            
            
            if(self.sendable)   {
                cell.codeTextField.enabled = true
                cell.contentView.alpha = 1
            }else   {
                cell.codeTextField.enabled = false
                println("cann't input code")
                cell.contentView.alpha = 0.5
            }
            
            
            
            if(self.sendable_codes[cell.codeTextField.tag] != nil)  {
                var check = self.sendable_codes[cell.codeTextField.tag]
                if let check :Bool = self.sendable_codes[cell.codeTextField.tag]  {
                    if(check)    {
                        
                    }else   {
                        cell.imageview_center.image = UIImage(named: "textfield_center_red")
                        cell.imageview_curve.image = UIImage(named: "textfield_curve_red")
                        cell.imageview_curve_r.image = UIImage(named: "textfield_curve_r_red")
                    }
                    
                }
            }else   {
                        cell.imageview_center.image = UIImage(named: "textfield_center")
                        cell.imageview_curve.image = UIImage(named: "textfield_curve")
                        cell.imageview_curve_r.image = UIImage(named: "textfield_curve_r")
            }
            
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            if (ratio < 1.5) {
                return UIScreen.mainScreen().bounds.size.width * (706/1080)
            } else {
                return UIScreen.mainScreen().bounds.size.width * (706/1080)
            }
        } else if (indexPath.row == 2) {
            if (ratio < 1.5) {
                return (UIScreen.mainScreen().bounds.size.width - 220) * (223/1013)
            } else {
                return (UIScreen.mainScreen().bounds.size.width - 35) * (223/1013)
            }
        } else if (indexPath.row == self.row - 3)    {
            // For Send Button Cell
            return 20
        }else if (indexPath.row == self.row - 2)    {
            return 50
        }else if (indexPath.row == self.row - 1)    {
            return 44
        }else   {
            // For Code Cell
            return 44
        }
    }
    
    // MARK: - textfield delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField
        println("textfield : \(textField.tag)")
//        self.tableView.reloadData()
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField.tag == 99) {
            if (self.checkValidPhoneNumber(textField.text)) {
                self.mobileno = textField.text
                self.keychain.setObject("mobile", value: self.mobileno)
                println("check validate")
//                if (self.row > 6) {
//                    self.row -= 9
//                }
//                self.checkDailyQuota()
            }else   {
                self.mobileno = textField.text
                self.keychain.setObject("mobile", value: "")
            }
        } else {
            self.codes[textField.tag] = textField.text
            self.sendable_codes.removeValueForKey(textField.tag)
            println(self.codes)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        activeTextField?.resignFirstResponder()
        //println("check")
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField.tag == 99) {
            let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
            return newLength <= 10
        } else {
            let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
            return newLength <= 11
        }
    }
    
    
    // MARK: - navbar delegate
    
    func tapMenuButton() {
        self.activeTextField?.resignFirstResponder()
        
        var scnc = self.navigationController as! HomeNavigationController
        scnc.drawer.open()
        self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "Click_menu")
    }
    
    func tapNotiButton() {
        self.controllerManager.loadWinnerList()
        self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "BT_announce")
//        var wvc = WinnerListTableViewController(nibName: "WinnerListTableViewController", bundle: nil)
//        self.navigationController?.pushViewController(wvc, animated: true)
    }
    
    // MARK: - cell delegate
    
    func tapAddMoreButton() {
        if (self.row <= 6) {
            self.row += 9
            self.tableView.reloadData()
            self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Click_addcode")
        }
    }
    
   
    // MARK: - popup delegate
    
    func tapClosePopUp() {
        self.estPopUpView.removeFromSuperview()
        self.tableView.reloadData()
    }
    
    func tapPopUpFinishCloseButton() {
        self.popUpFinishView.removeFromSuperview()
        self.tableView.reloadData()
    }
    
    func tapShareButton(isWinner: Bool) {
        self.estPopUpView.removeFromSuperview()
        self.tableView.reloadData()
    }
    
    // MARK: - sendcode
    
    func checkValidPhoneNumber(phoneNumber: String) -> Bool {
        
        
        var number = "".join(phoneNumber.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet))
        
        if (number.length() == 10) {
            var infix = phoneNumber.substringToIndex(advance(number.startIndex, 2))
            println("check infix : \(infix)")
            
            if (infix == "08" || infix == "06" || infix == "09") {
                if (number.length() == 10) {
                    self.sendable = true
                    self.tableView.reloadData()
                    return true
                }
            }
        }
        self.sendable = false
        self.tableView.reloadData()
        return false
    }
    
    // MARK: - api
    
    func checkActiveApp() {
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        var request = estHTTPService.checkActiveApp(Callback() { (json, success, errorString, error) in
                if (success) {
                    println(json)
                    
                    if let data = json {
                        var tmp = data["app"][0]
                        println(tmp["active"].string)
//                        println(data["app"][0])
                        
                        if let active = tmp["active"].string    {
                            if(active == "0")   {
                                self.navigationController?.view.addSubview(self.popUpFinishView)
                                self.finish = true
//                                self.sendable = false
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            })
    }
    
    // MARK: - keyboard delegate
    
    func keyboardWillBeHidden() {
        // check valid phonenumber
        
        textFieldDidEndEditing(self.activeTextField!)
        for subview in self.tableView.visibleCells() {
            if subview is TelephoneTableViewCell {
                var cell = subview as! TelephoneTableViewCell
                if (cell.telTextField.text != "") {
//                    println(self.checkValidPhoneNumber(cell.telTextField.text))
                }
            }
        }
    }
    
    
    func tapped(){
        self.activeTextField?.resignFirstResponder()
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        var parameters = [
            "stat": "estpromo",
            "param1": "ios",
            "param3": "mobileno"
        ]
        
        if (self.isWinner) {
            parameters["param2"] = "shareFBWinner"
        } else {
            parameters["param2"] = "shareFBSendcode"
        }
        
        if (self.keychain.getObject("fbid") != "") {
            parameters["fbid"] = self.keychain.getObject("fbid")
        }
        
        self.isWinner = false
        
        self.estHTTPService.sendApplicationStatLog(parameters)
        self.estPopUpView.removeFromSuperview()
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
    }
    
    func pushNotification() {
        self.controllerManager.loadWinnerList()
    }
    
    func setButtonImage() {
        if (self.row > 6) {
            self.addMoreCell!.button.setImage(UIImage(named: "max"), forState: UIControlState.Normal)
        } else {
            if (self.left <= 1) {
                self.addMoreCell!.button.hidden = true
            } else {
                self.addMoreCell!.button.setImage(UIImage(named: "more"), forState: UIControlState.Normal)
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

    
    
    
    // MARK : - SEND CODE VALIDATION
     func tapSendButton() {
        self.activeTextField?.resignFirstResponder()
//        self.view.endEditing(true)
//        
//        println(self.codes)
//        
//        checkSendableCode()
        
        var codes = [String]()
        if(self.codes.count > 0)    {
            for(key, value) in self.codes   {
                if(value != "")    {
                    codes.append(value)
                }else   {
                    self.codes.removeValueForKey(key)
                    self.sendable_codes.removeValueForKey(key)
                }
            }
            if(codes.count == 0)    {
                println("Alertttt")
                /// show alert text
            }else   {
                println("Senddddd Codeeee !")
                println(self.codes)
                if(checkSendableCode())   {
                    self.sendCodes(codes)
                    self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Click_submitCode")
                }else   {
                    self.alertmessage = true
                }
                
            }
        }else   {
            println("alert !!!!")
            self.codes.removeAll(keepCapacity: false)
            self.error_sendcode.removeAll(keepCapacity: false)
            
            // show alert text
        }
        self.tableView.reloadData()
        
    }
    
    
    
    func checkSendableCode() -> Bool    {
        
        // --------------------------------------
        // Check length
        // --------------------------------------
        for (key,value) in self.codes   {
            
            
            // Check Empty  and check input only one textfield
            if(value == "" || self.codes.count <= 1 )   {
                self.sendable_codes.removeValueForKey(key)
            }
            
            // check length of code
            if(value.length() == 11) {
//                self.sendable_codes[key] = true
                self.sendable_codes.removeValueForKey(key)
            }else   {
                self.sendable_codes[key] = false
                
            }
            
            // check same code
            
            if(value.length() == 11)    {
             for(tag,text) in self.codes {
                var count = 0
                for(tag2,text2) in self.codes   {
                    if(text == text2)   {
                        count++
                    }
                }
                
                if(count >= 2)   {
                    println("have same code")
                    self.sendable_codes[tag] = false
                }else   {
                    self.sendable_codes.removeValueForKey(key)
                }
            }               
            }

            
        }
        
        println(self.codes)
        println(self.sendable_codes)
        
        if(self.sendable_codes.count == 0)  {
            return true
        }else   {
            return false
        }
    }
    
    
    
    func sendCodes(codes: [String]) {
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        if (self.keychain.getObject("mobile") != "") {
            var request = estHTTPService.sendCode(self.keychain.getObject("mobile"), codes: codes, cb: Callback() { (sendcodeStandardResponse, success, errorString, error) in
                if (success) {
                    if let sr: SendcodeStandardResponse = sendcodeStandardResponse {
                        if (sr.result == "complete") {
                            var validation = true
                            if let items = sr.codelist.array    {
                                for item in items   {
                                    if let text = item["text"].string   {
                                        if let code = item["code"].string {
                                            println(text)
                                            println(code)
                                            if(text == "INCORRECT_FORMAT" || text == "EXISTING_CODE")  {
                                                validation = false
                                                self.error_sendcode[code] = false
                                                self.alertmessage = true
                                            }else   {
                                                self.error_sendcode[code] = true
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if(validation)  {
                                //                            sr.codelist[0]
                                
                                self.keychain.setObject("popup", value: "thankyou")
                                self.estPopUpView.initEstPopUpView(UIImage(named: "popup_thankyou")!, sharable: true, delegate: self)
                                //
                                self.navigationController?.view.addSubview(self.estPopUpView)
                                self.codes.removeAll(keepCapacity: false)
//                                self.sendable_sendcode.removeAll(keepCapacity: false)
                                self.sendable_codes.removeAll(keepCapacity: false)
                                self.alertmessage = false
                            }
                            
                            // if all not valid
                            println("---------------------")
                            println(self.error_sendcode)
                            if(self.error_sendcode.count != 0)  {
                                for(text1,sendable) in self.error_sendcode   {
                                    for(tag,text2) in self.codes {
                                        if(text1 == text2)  {
                                            if(sendable == false)   {
                                                self.sendable_codes[tag] = false
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            println("-----------------")
                            println(self.codes)
                            self.tableView.reloadData()
                            
                            
                            return
                        }
                    }
                }
                //                 show error
                })
        }
    }

}
