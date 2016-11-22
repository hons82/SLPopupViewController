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
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromBottom
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToTop
       self.displayViewController(config)
    }
    @IBAction func btnTopBottom(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromTop
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToBottom
        self.displayViewController(config)
    }
    @IBAction func btnBottomBottom(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromBottom
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToBottom
        self.displayViewController(config)
    }
    @IBAction func btnTopTop(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromTop
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToTop
        self.displayViewController(config)
    }
    @IBAction func btnLeftLeft(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromLeft
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToLeft
        self.displayViewController(config)
    }
    @IBAction func btnLeftRight(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromLeft
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToRight
        self.displayViewController(config)

    }
    @IBAction func btnRightLeft(sender:UIButton) {
        let config = SLPopupViewControllerConfig()
        config.showAnimation = SLPopupViewShowAnimation.SlideInFromRight
        config.dismissAnimation = SLPopupViewDismissAnimation.SlideOutToLeft
        self.displayViewController(config)

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

