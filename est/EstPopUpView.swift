//
//  EstPopUpView.swift
//  EST
//
//  Created by meow kling :3 on 9/1/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class EstPopUpView: UIView {
    
    @IBOutlet var view: UIView!
    
    var estPopUpDetail: EstPopUpDetailView!
    var popUpFinishView: PopUpFinishView!
    var tvcPopUpView: TVCPopUpView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("EstPopUpView", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.view.userInteractionEnabled = true
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initEstPopUpView(detailImage: UIImage, sharable: Bool, delegate: EstPopUpDetailDelegate) {
        // init est pop-up detail
        var size = UIScreen.mainScreen().bounds.size
        self.estPopUpDetail = EstPopUpDetailView(frame: CGRectMake((size.width - 290) / 2, (size.height / 2) - 170, 290, 320))
        self.estPopUpDetail.delegate = delegate
        self.estPopUpDetail.initEstPopUpDetailView(detailImage, sharable: sharable)
        self.view.addSubview(estPopUpDetail)
        self.view.bringSubviewToFront(estPopUpDetail)
    }
    
    func initEstPopUpFinishView(delegate: PopUpFinishViewDelegate) {
        var size = UIScreen.mainScreen().bounds.size
        self.popUpFinishView = PopUpFinishView(frame: CGRectMake((size.width - 290) / 2, (size.height / 2) - 170, 290, 316))
        self.popUpFinishView.delegate = delegate
        self.view.addSubview(self.popUpFinishView)
        self.view.bringSubviewToFront(self.popUpFinishView)
    }
    
    func initTVCPopUpView(delegate: TVCPopUpViewDelegate) {
        var size = UIScreen.mainScreen().bounds.size
        var calsize = CGSizeMake(size.width - 30, (size.width * 888) / 1116)

        self.tvcPopUpView = TVCPopUpView(frame: CGRectMake((size.width - (calsize.width)) / 2, (size.height / 2) - (calsize.height / 2), calsize.width, calsize.height))
        self.tvcPopUpView.delegate = delegate
        
        self.view.addSubview(self.tvcPopUpView)
        self.view.bringSubviewToFront(self.tvcPopUpView)
//        self.tvcPopUpView.webView.loadRequest(self.tvcPopUpView.request)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
