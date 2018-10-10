//
//  ViewController.swift
//  SLPopupViewControllerDemo
//
//  Created by Nguyen Duc Hoang on 9/13/15.
//  Copyright © 2015 Nguyen Duc Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyPopupViewControllerDelegate {
    @IBAction func btnBottomTop(sender:UIButton) {
       let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromBottom
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToTop
        self.displayViewController(config: config)
    }
    @IBAction func btnTopBottom(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromTop
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToBottom
        self.displayViewController(config: config)
    }
    @IBAction func btnBottomBottom(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromBottom
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToBottom
        self.displayViewController(config: config)
    }
    @IBAction func btnTopTop(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromTop
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToTop
        self.displayViewController(config: config)
    }
    @IBAction func btnLeftLeft(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromLeft
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToLeft
        self.displayViewController(config: config)
    }
    @IBAction func btnLeftRight(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromLeft
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToRight
        self.displayViewController(config: config)

    }
    @IBAction func btnRightLeft(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.slideInFromRight
        config.dismissAnimation = SLPopupViewDismissAnimation.slideOutToLeft
        self.displayViewController(config: config)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func displayViewController(config: SLPopupViewControllerConfig?) {
        let myPopupViewController:MyPopupViewController = MyPopupViewController(nibName:"MyPopupViewController", bundle: nil)
        myPopupViewController.delegate = self
        if let _ = config {
            presentPopupViewController(myPopupViewController, config: config!)
        } else {
            presentPopupViewController(myPopupViewController, config: SLPopupViewControllerConfig())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: MyPopupViewControllerProtocol
    func pressOK(sender: MyPopupViewController) {
        print("press OK", terminator: "\n")
        self.dismissPopupViewController()
    }
    
    func pressCancel(sender: MyPopupViewController) {
        print("press Cancel", terminator: "\n")
        self.dismissPopupViewController()
    }

}

