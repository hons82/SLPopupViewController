//
//  UIVViewController-SLPopup.swift
//  AnonyChat
//
//  Created by Nguyen Duc Hoang on 9/6/15.
//  Copyright © 2015 Home. All rights reserved.
//

import UIKit
import QuartzCore
import ObjectiveC

var kpopupViewController: UInt8 = 0
var kOverlayViewAssociationKey: UInt8 = 1
var kConfigAssociationKey: UInt8 = 2

let kSLViewDismissKey = "kSLViewDismissKey"

extension UIViewController {
    
    fileprivate var overlayView:UIView? {
        get {
            return objc_getAssociatedObject(self, &kOverlayViewAssociationKey) as? UIView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kOverlayViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    fileprivate var popupViewController:UIViewController? {
        get {
            return objc_getAssociatedObject(self, &kpopupViewController) as? UIViewController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kpopupViewController, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Popup config
    fileprivate var config: SLPopupViewControllerConfig? {
        get {
            return objc_getAssociatedObject(self, &kConfigAssociationKey) as? SLPopupViewControllerConfig
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kConfigAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Public methods
    
    public func presentPopupViewController(_ popupViewController: UIViewController, config: SLPopupViewControllerConfig) {
        self.popupViewController = popupViewController
        self.config = config
        let sourceView:UIView = self.getTopView()
        let popupView:UIView = popupViewController.view
        popupView.autoresizingMask = [.flexibleTopMargin,.flexibleLeftMargin,.flexibleRightMargin,.flexibleBottomMargin]
        if(sourceView.subviews.contains(popupView)) {
            return
        }
        popupView.layer.shadowPath = UIBezierPath(rect: popupView.bounds).cgPath
        popupView.layer.cornerRadius = config.cornerRadius
        popupView.layer.shouldRasterize = true
        popupView.layer.rasterizationScale = UIScreen.main.scale
        
        overlayView = UIView(frame: sourceView.bounds)
        overlayView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView!.backgroundColor = config.overlayColor
        overlayView!.alpha = 0.0
        
        //Background is button
        let dismissButton: UIButton = UIButton(type: .custom)
        dismissButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dismissButton.backgroundColor = UIColor.clear
        dismissButton.frame = sourceView.bounds
        overlayView!.addSubview(dismissButton)
        
        popupView.alpha = 0.0
        sourceView.addSubview(overlayView!)
        sourceView.addSubview(popupView)
        
        if config.dismissTouchBackground {
            dismissButton.addTarget(self, action: #selector(UIViewController.btnDismissViewControllerWithAnimation(_:)), for: .touchUpInside)
        }
        
        showAnimation()
    }
    
    public func dismissPopupViewController() {
        dismissAnimation()
    }
    
    // MARK: -
    // MARK: Show
    
    fileprivate func showAnimation() {
        if let config = config {
            switch (config.showAnimation) {
            case .none:
                completionShowAnimation(true)
            case .fadeIn:
                fadeViewIn()
            case .slideInFromTop, .slideInFromBottom, .slideInFromLeft, .slideInFromRight:
                slideViewIn()
            case .custom:
                if let popupView = self.popupViewController?.view {
                    config.showCustomAnimation(self.getTopView(), popupView, { self.completionShowAnimation(true) })
                }
            }
        }
    }
    
    fileprivate func completionShowAnimation(_ finished: Bool) {
        if let completion = config?.showCompletion, let popupViewController = self.popupViewController {
            completion(popupViewController)
        }
    }
    
    // MARK: Dismiss
    
    fileprivate func dismissAnimation() {
        if let config = config {
            switch (config.dismissAnimation) {
            case .none:
                completionDismissAnimation(true)
            case .fadeOut:
                fadeViewOut()
            case .slideOutToTop, .slideOutToBottom, .slideOutToLeft, .slideOutToRight:
                slideViewOut()
            case .custom:
                if let popupView = self.popupViewController?.view {
                    config.dismissCustomAnimation(self.getTopView(), popupView, { self.completionDismissAnimation(true) })
                }
            }
        }
    }
    
    fileprivate func completionDismissAnimation(_ finished: Bool) {
        if let completion = config?.dismissCompletion, let popupViewController = self.popupViewController {
            // remove view
            self.overlayView?.removeFromSuperview()
            self.overlayView = nil
            self.popupViewController?.view.removeFromSuperview()
            self.popupViewController = nil
            self.config = nil
            
            completion(popupViewController)
        }
        
    }
    
    // MARK: -
    // MARK: Slide
    
    fileprivate func slideViewIn() {
        if let popupSize: CGSize = self.popupViewController?.view.bounds.size {
            let sourceSize: CGSize = self.getTopView().bounds.size
            var popupStartRect:CGRect
            if let config = config {
                switch (config.showAnimation) {
                case .slideInFromBottom:
                    popupStartRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: sourceSize.height, width: popupSize.width, height: popupSize.height)
                case .slideInFromLeft:
                    popupStartRect = CGRect(x: -sourceSize.width, y: (sourceSize.height - popupSize.height)/2, width: popupSize.width, height: popupSize.height)
                case .slideInFromTop:
                    popupStartRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: -sourceSize.height, width: popupSize.width, height: popupSize.height)
                default:
                    popupStartRect = CGRect(x: sourceSize.width, y: (sourceSize.height - popupSize.height)/2, width: popupSize.width, height: popupSize.height)
                }
                
                let popupEndRect:CGRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: (sourceSize.height - popupSize.height)/2, width: popupSize.width, height: popupSize.height)
                self.popupViewController?.view.frame = popupStartRect
                self.popupViewController?.view.alpha = 1.0
                UIView.animate(withDuration: config.showAnimationDuration, animations: { () -> Void in
                    self.popupViewController?.viewWillAppear(false)
                    self.overlayView?.alpha = 0.5
                    self.popupViewController?.view.frame = popupEndRect
                }, completion: { (finished) -> Void in
                    self.popupViewController?.viewDidAppear(false)
                    self.completionShowAnimation(true)
                }) 
            }
        }
    }
    
    fileprivate func slideViewOut() {
        if let popupView: UIView = self.popupViewController?.view {
            let sourceSize: CGSize = self.getTopView().bounds.size
            var popupEndRect:CGRect
            if let config = config {
                switch (config.dismissAnimation) {
                case .slideOutToTop:
                    popupEndRect = CGRect(x: (sourceSize.width - popupView.bounds.size.width)/2, y: -popupView.bounds.size.height, width: popupView.bounds.size.width, height: popupView.bounds.size.height)
                case .slideOutToBottom:
                    popupEndRect = CGRect(x: (sourceSize.width - popupView.bounds.size.width)/2, y: sourceSize.height, width: popupView.bounds.size.width, height: popupView.bounds.size.height)
                case .slideOutToRight:
                    popupEndRect = CGRect(x: sourceSize.width, y: popupView.frame.origin.y, width: popupView.bounds.size.width, height: popupView.bounds.size.height)
                default:
                    popupEndRect = CGRect(x: -popupView.bounds.size.width, y: popupView.frame.origin.y, width: popupView.bounds.size.width, height: popupView.bounds.size.height)
                }
                
                UIView.animate(withDuration: config.dismissAnimationDuration, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.popupViewController?.viewWillDisappear(false)
                    self.overlayView!.alpha = 0.0
                    popupView.frame = popupEndRect
                }) { (finished) -> Void in
                    self.completionDismissAnimation(true)
                    popupView.removeFromSuperview()
                    self.overlayView?.removeFromSuperview()
                    self.popupViewController?.viewDidDisappear(false)
                    self.popupViewController = nil
                }
            }
        }
    }
    
    // MARK: Fade
    
    fileprivate func fadeViewIn() {
        if let popupView: UIView = self.popupViewController?.view, let config = config {
            let sourceSize: CGSize = self.getTopView().bounds.size
            popupView.frame = CGRect(x: (sourceSize.width - popupView.bounds.size.width)/2,
                                     y: (sourceSize.height - popupView.bounds.size.height)/2,
                                     width: popupView.bounds.size.width,
                                     height: popupView.bounds.size.height)
            popupView.alpha = 0.0
            
            UIView.animate(withDuration: config.showAnimationDuration, animations: { () -> Void in
                self.popupViewController!.viewWillAppear(false)
                self.overlayView?.alpha = 0.5
                popupView.alpha = 1.0
            }, completion: { (finished) -> Void in
                self.popupViewController?.viewDidAppear(false)
                self.completionShowAnimation(true)
            }) 
        }
    }
    
    fileprivate func fadeViewOut() {
        if let popupView = self.popupViewController?.view, let config = config {
            UIView.animate(withDuration: config.dismissAnimationDuration, animations: { () -> Void in
                self.popupViewController?.viewWillDisappear(false)
                self.overlayView?.alpha = 0.0
                popupView.alpha = 0.0
            }, completion: { (finished) -> Void in
                self.completionDismissAnimation(true)
                popupView.removeFromSuperview()
                self.overlayView?.removeFromSuperview()
                self.popupViewController?.viewDidDisappear(false)
                self.popupViewController = nil
            }) 
        }
    }
    
    // MARK: - Button callback
    
    @objc func btnDismissViewControllerWithAnimation(_ btnDismiss : UIButton) {
        dismissPopupViewController()
    }
    
    // MARK: - Helper
    
    fileprivate func getTopView() -> UIView {
        var recentViewController:UIViewController = self
        if let _ = recentViewController.parent {
            recentViewController = recentViewController.parent!
        }
        return recentViewController.view
    }
    
}
