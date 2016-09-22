//
//  CheckPrizeTableViewController.swift
//  EST
//
//  Created by meow kling :3 on 9/1/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class CheckPrizeTableViewController: UITableViewController, EstPopUpDetailDelegate, CheckPrizeButtonDelegate, UITextFieldDelegate, FBSDKSharingDelegate, TVCPopUpViewDelegate {
    
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width
    let keychain = KeychainUtility.keychainUtilityInstance
    let controllerManager = ControllerManager.controllerManagerInstance
    var estHTTPService = ESTHTTPService.estHTTPServiceInstance
    
    var estPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    var tvcPopUpView = EstPopUpView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    var mobileno = ""
    
    var textfield:UITextField?
    var imageView_NoticeBackground: UIImageView?
    var view_NoticeBackground: UIView?
    
    var isWinner = false
    
    var winners = [Winner]()
    
    var imagename = ""
    
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
        
//        var tapReg = UITapGestureRecognizer(target: self, action: Selector("tapped"))
//        self.view.addGestureRecognizer(tapReg)
        
//        self.tableView.registerNib(UINib(nibName: "CheckPrizeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeHeaderCell")
        self.tableView.registerNib(UINib(nibName: "TelephoneTableViewCell", bundle: nil), forCellReuseIdentifier: "telCell")
//        self.tableView.registerNib(UINib(nibName: "CheckPrizeButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeButtonCell")
        
        self.tableView.registerNib(UINib(nibName: "CheckPrizeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeHeaderCell")
//        self.tableView.registerNib(UINib(nibName: "TelephoneTableViewCell", bundle: nil), forCellReuseIdentifier: "telephoneCell")
        self.tableView.registerNib(UINib(nibName: "CheckPrizeButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeButtonCell")
        self.tableView.registerNib(UINib(nibName: "CheckPrizeDetailTextTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeDetailCell")
        self.tableView.registerNib(UINib(nibName: "CheckPrizeSeperatorTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeSeperatorCell")
        self.tableView.registerNib(UINib(nibName: "CheckPrizeNoticeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeNoticeHeaderCell")
        self.tableView.registerNib(UINib(nibName: "CheckPrizeNoticeTableViewCell", bundle: nil), forCellReuseIdentifier: "checkPrizeNoticeCell")
        
        
        self.tableView.backgroundColor = EstColors.MAIN_BLUE_COLOR
        
        var bgImage = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (6000/1080)))
        var bg = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (6000/1080)))
        bgImage.image = UIImage(named: "winner_bg")
        bgImage.autoresizesSubviews = false
        bg.contentMode = UIViewContentMode.TopLeft
        bg.autoresizesSubviews = false
        bg.addSubview(bgImage)
        self.tableView.backgroundView?.contentMode = UIViewContentMode.TopLeft
        self.tableView.backgroundView = bg
        
        var logo = UIImageView(image: UIImage(named: "navbar_logo_1"))
        logo.frame = CGRectMake(0, 4, ((self.navigationController!.navigationBar.bounds.size.height - 8) * (176/153)), self.navigationController!.navigationBar.bounds.size.height - 8)
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
        
        self.getWinnerList()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.estHTTPService.sendEstPromoCodeTracker("Page", action: "opened", label: "estSendCode-Check")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tvcPopUp"), name: "tvcPopUp", object: nil)
        
        if (self.keychain.getObject("mobile") != "") {
            println("key chain not empty at sendcode")
            self.checkValidPhoneNumber(self.keychain.getObject("mobile"))
            self.mobileno = self.keychain.getObject("mobile")
            //self.tableView.reloadData()
        }else   {
            println("key chain is empty at sendcode")
            self.mobileno = ""
            self.tableView.reloadData()
            //self.checkValidPhoneNumber(self.keychain.getObject("mobile"))
            //self.tableView.reloadData()
        }
        
        
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
        return 6 + self.winners.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("checkPrizeHeaderCell", forIndexPath: indexPath) as! CheckPrizeHeaderTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else if (indexPath.row == 1)  {
            let cell = tableView.dequeueReusableCellWithIdentifier("checkPrizeDetailCell", forIndexPath: indexPath) as! CheckPrizeDetailTextTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCellWithIdentifier("telCell", forIndexPath: indexPath) as! TelephoneTableViewCell
            self.textfield = cell.telTextField
            cell.telTextField.text = ""
            cell.telTextField.text = self.mobileno
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            
            cell.telTextField.text = self.keychain.getObject("mobile")
            if(self.keychain.getObject("mobile") != "") {
                cell.telTextField.text = self.keychain.getObject("mobile")
                cell.imageview_signcorrect.hidden = false
            }else   {
                cell.telTextField.text = self.mobileno
                cell.imageview_signcorrect.hidden = true
            }
            
            
            
            cell.backgroundColor = UIColor.clearColor()
            cell.telTextField.delegate = self
            return cell
        } else if (indexPath.row == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("checkPrizeButtonCell", forIndexPath: indexPath) as! CheckPrizeButtonTableViewCell
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if(self.keychain.getObject("announce") == "0")  {
                cell.button_checkprize.enabled = false
                cell.button_checkprize.alpha = 0.4
            }else   {
                cell.button_checkprize.enabled = true
                cell.button_checkprize.alpha = 1.0
            }
            
            cell.backgroundColor = UIColor.clearColor()
            return cell
        } else if (indexPath.row == 4){
            let cell = tableView.dequeueReusableCellWithIdentifier("checkPrizeSeperatorCell", forIndexPath: indexPath) as! CheckPrizeSeperatorTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }else if (indexPath.row == 5)   {
            let cell = tableView.dequeueReusableCellWithIdentifier("checkPrizeNoticeHeaderCell", forIndexPath: indexPath) as! CheckPrizeNoticeHeaderTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }else {
            
            // indexPath.row == 6 --> 16
            let cell = tableView.dequeueReusableCellWithIdentifier("checkPrizeNoticeCell", forIndexPath: indexPath) as! CheckPrizeNoticeTableViewCell
            var size = UIScreen.mainScreen().bounds.size
            
            if( self.ratio < 1.5 )  {
                if(indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 16)    {
                    imageView_NoticeBackground = UIImageView(frame:CGRectMake(0.0, 0.0, size.width - 100 , (size.width - 100) * (299/1005)))
                    view_NoticeBackground = UIView(frame: CGRectMake(0.0, 0.0, size.width - 100, (size.width - 100) * (299/1005)))
                }else   {
                    imageView_NoticeBackground = UIImageView(frame:CGRectMake(0.0, 0.0, size.width - 100 , (size.width - 100) * (163/1005)))
                    view_NoticeBackground = UIView(frame: CGRectMake(0.0, 0.0, size.width - 100, (size.width - 100) * (163/1005)))
                }
            }else   {
                if(indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 16)    {
                    imageView_NoticeBackground = UIImageView(frame:CGRectMake(0.0, 0.0, size.width - 15 , (size.width - 15) * (299/1005)))
                    view_NoticeBackground = UIView(frame: CGRectMake(0.0, 0.0, size.width - 15, (size.width - 15) * (299/1005)))
                }else   {
                    imageView_NoticeBackground = UIImageView(frame:CGRectMake(0.0, 0.0, size.width - 15 , (size.width - 15) * (163/1005)))
                    view_NoticeBackground = UIView(frame: CGRectMake(0.0, 0.0, size.width - 15, (size.width - 15) * (163/1005)))
                }
            }
            
            
            
            if (self.winners.count > 0 )    {
                var winner = self.winners[indexPath.row - 6]
                if(winner.status == "true") {
                    self.imagename = "winner_notice_active_" + String("\(indexPath.row - 6 + 1)")
                }else   {
                    self.imagename = "winner_notice_inactive_" + String("\(indexPath.row - 6 + 1)")
                }
            }else   {
                self.imagename = "winner_notice_inactive_" + String("\(indexPath.row - 6 + 1)")
            }
            
//            var image_name = "winner_notice_inactive_" + String("\(indexPath.row - 6 + 1)")
            imageView_NoticeBackground!.image = UIImage(named: self.imagename)
            imageView_NoticeBackground!.autoresizesSubviews = false
            
            view_NoticeBackground!.contentMode = UIViewContentMode.TopLeft
            view_NoticeBackground!.autoresizesSubviews = false
            view_NoticeBackground!.addSubview(imageView_NoticeBackground!)
            imageView_NoticeBackground!.center.x = cell.center.x
            
            cell.backgroundView?.contentMode = UIViewContentMode.TopLeft
            cell.backgroundView = view_NoticeBackground
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.backgroundColor = UIColor.clearColor()
            
            
            
            return cell
            
            
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            // Keyvisual
            if (self.ratio < 1.5) {
                return UIScreen.mainScreen().bounds.size.width * (415/1080)
            } else {
                return UIScreen.mainScreen().bounds.size.width * (415/1080)
            }
        } else if (indexPath.row == 1) {
            // Check Prize Detail Text
            return UIScreen.mainScreen().bounds.size.width * (148/804)
        } else if (indexPath.row == 2)  {
            // Input Telephone Form
            return 44
        }else if (indexPath.row == 3)   {
            // Check Prize Button
            return 75
        }else if (indexPath.row == 4)   {
            // Seperator Line
            return 10
        }else if (indexPath.row == 5)   {
            // Notice Prize Header
            return UIScreen.mainScreen().bounds.size.width * (147/765)
        }else if (indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 16)   {
            if( self.ratio < 1.5 )  {
                return ( UIScreen.mainScreen().bounds.size.width - 100 ) * (299/1005) + 8
            }else   {
                return ( UIScreen.mainScreen().bounds.size.width ) * (299/1005) + 3
            }
        }else{
            // Notice Prize
            if (self.ratio < 1.5)   {
                return ( UIScreen.mainScreen().bounds.size.width - 100 ) * (163/1005) + 8
            }else   {
                return ( UIScreen.mainScreen().bounds.size.width ) * (163/1005) + 3
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("did select row at index path")
        if (self.winners.count > 0 && indexPath.row > 5) {
            println("check")
            var winner = self.winners[(indexPath.row - 6)]
            var url = NSURL(string: winner.url)
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    
    
    
    
    // MARK: - textfield delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textfield = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("textfiled at end editing : \(textField.text)")
        
        
        if(self.checkValidPhoneNumber(textField.text))  {
            self.mobileno = textField.text
            self.keychain.setObject("mobile", value: self.mobileno)
            println("set key chain at check prize")
            // show correct sign
        }else   {
            println("reset key chain at check prize")
            self.mobileno = textField.text
            self.keychain.setObject("mobile", value: "")
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
        return newLength <= 10
    }
    
    // MARK: - check prize button delegate
    
    func tapCheckPrizeButton() {
        self.textFieldDidEndEditing(self.textfield!)
        
        self.getWinnerByMobileNumber()
        self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Click_check")
    }
    
    // MARK: - drawer delegate
    
    func tapMenuButton() {
        self.textfield?.resignFirstResponder()
        var scnc = self.navigationController as! HomeNavigationController
        scnc.drawer.open()
    }
    
    func tapNotiButton() {
        self.controllerManager.loadWinnerList()
        self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "BT_announce")
    }
    
    // MARK: - popup delegate
    
    func tapClosePopUp() {
        self.estPopUpView.removeFromSuperview()
    }
    
    func tapShareButton(isWinner: Bool) {
    var content = FBSDKShareLinkContent()
    if (!isWinner) {
        
            content.contentURL = NSURL(string: self.keychain.getObject("share_url"))
            content.contentTitle = self.keychain.getObject("share_title")
            content.contentDescription = self.keychain.getObject("share_description")
            content.imageURL = NSURL(string: self.keychain.getObject("share_image"))
        
        } else {
        //self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Click_ShareSuccessWinSeat")
            self.estHTTPService.sendEstPromoCodeTracker("Button", action: "clicked", label: "Click_ShareWinS7")
            content.contentURL = NSURL(string: self.keychain.getObject("share_url"))
            content.contentTitle = self.keychain.getObject("share_title")
            content.contentDescription = self.keychain.getObject("share_description")
            content.imageURL = NSURL(string: self.keychain.getObject("share_image"))
        
        }
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
        
        if (isWinner) {
            self.isWinner = true
        } else {
            self.isWinner = false
        }
    }
    
    // MARK: - api
    
    func getWinnerByMobileNumber() {
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
//        println(self.mobileno)
        if (self.mobileno != "" && self.mobileno.length() == 10) {
            var request = estHTTPService.getWinnerByMobileNumber(self.mobileno, cb: Callback() { (json, success, errorString, error) in
                if (success) {
                    if let data = json {
                        println(data)
                        
                        
                        
                        
//                        var winner = WinningPrize.getWinningPrize(data["result"])
//                            println("winner : \(winner)")
                        if let result = data["result"].string {
                            
                            var imageName = ""
                            
                            if(result == "notwinner") {
                               // "popup_loser"
                                imageName = "popup_loser"
                                self.keychain.setObject("popup", value: "loser")
                                self.estPopUpView.initEstPopUpView(UIImage(named: imageName)!, sharable: false, delegate: self)
                                self.estPopUpView.estPopUpDetail.isWinner = false
                            }else if ( result == "winner")  {
                                // type 1 : seat
                                // type 2 : phone
                                // "popup_winner"
                                var winnerprize: WinningPrize = WinningPrize.getWinningPrize(data)
                                
                                if( winnerprize.type == "1")    {
                                    if(winnerprize.round == "2" || winnerprize.round == "6" || winnerprize.round == "11") {
                                        imageName = "popup_winner_seat_\(winnerprize.round)"
                                        self.keychain.setObject("popup", value: "winner_seat")
                                    }else   {
                                        imageName = "popup_loser"
                                        self.keychain.setObject("popup", value: "loser")
                                    }
                                }else    {
                                    imageName = "popup_winner_phone_\(winnerprize.round)"
                                    self.keychain.setObject("popup", value: "winner_phone")
                                }
                                
//                                var x = data["code"].string
                                println("image name : \(imageName)")
                                self.estPopUpView.initEstPopUpView(UIImage(named: imageName)!, sharable: true, delegate: self)
                                
                                
                                if(self.keychain.getObject("popup") == "loser")    {
                                    self.estPopUpView.estPopUpDetail.winnerLabel.hidden = true
                                }else   {
                                    self.estPopUpView.estPopUpDetail.winnerLabel.text = winnerprize.code
                                    self.estPopUpView.estPopUpDetail.winnerLabel.hidden = false
                                }
                                
                                
                                
                            }else   {
                                // "wating time
                                // disable check button
                            }
                            self.navigationController?.view.addSubview(self.estPopUpView)
                        } else {
                            
                        }
                    }
                } else {
                    println("error")
                }
            })
        }
        
    }
    
    func tapped(){
        println("fuck")
        if let tf = self.textfield {
            self.textfield?.resignFirstResponder()
        }
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        println("share completed")
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
        println("cancel share")
    }
    
    func tvcPopUp() {
        self.tvcPopUpView.initTVCPopUpView(self)
        self.navigationController?.view.addSubview(self.tvcPopUpView)
    }
    
    func tapTVCPopUpCloseButton() {
        self.tvcPopUpView.tvcPopUpView.webView.loadHTMLString(nil, baseURL: nil)
        self.tvcPopUpView.removeFromSuperview()
    }
    
    
    
    
    
    
    func checkValidPhoneNumber(phoneNumber: String) -> Bool    {
        var infix = ""
        if(phoneNumber != "")   {
            infix = phoneNumber.substringToIndex(advance(phoneNumber.startIndex, 2))
        }
        
        if (infix == "08" || infix == "06" || infix == "09") {
            if (count(phoneNumber) == 10) {
                self.tableView.reloadData()
                
                return true
            }
        }
        self.tableView.reloadData()
        return false
    }
    
    
    func getWinnerList() {
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        var request = estHTTPService.getWinnerList(Callback() { (winners, success, errorString, error) in
            if (success) {
                if let wnrs = winners {
                    self.winners = wnrs
//                    self.setIsOpenWinnerList()
//                    println(winners)
                    self.tableView.reloadData()
                }
            } else {
                // error
            }
            })
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
