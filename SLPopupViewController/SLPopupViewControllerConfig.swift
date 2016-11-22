//
//  SLPopupViewControllerConfig.swift
//  SLPopupViewControllerDemo
//
//  Created by Hannes Tribus on 29/10/15.
//  Copyright © 2015 Nguyen Duc Hoang. All rights reserved.
//

import UIKit

/**
 Show Animation type
 */
public enum SLPopupViewShowAnimation:Int {
    case none
    case fadeIn
    case slideInFromTop
    case slideInFromBottom
    case slideInFromLeft
    case slideInFromRight
    case custom // Need implements 'showCustomAnimation'
}

/**
 Dismiss Animation
 */
public enum SLPopupViewDismissAnimation {
    case none
    case fadeOut
    case slideOutToTop
    case slideOutToBottom
    case slideOutToLeft
    case slideOutToRight
    case custom // Need implements 'dismissCustomAnimation'
}

/**
 *  Popup Config
 */
open class SLPopupViewControllerConfig {
    
    /// Dismiss touch the Background if ture.
    open var dismissTouchBackground = true
    
    /// Popup corner radius value.
    open var cornerRadius: CGFloat = 0
    
    /// Background overlay color.
    open var overlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    /// Show animation type.
    open var showAnimation = SLPopupViewShowAnimation.fadeIn
    open var showAnimationDuration: TimeInterval = 0.35
    
    /// Dismiss animation type.
    open var dismissAnimation = SLPopupViewDismissAnimation.fadeOut
    open var dismissAnimationDuration: TimeInterval = 0.35
    
    /// Clouser show animation is completed.
    /// Pass the popup view to argument.
    open var showCompletion: ((UIViewController) -> Void)? = nil
    
    /// Clouser disimss animation is completed.
    /// Pass the popup view to argument.
    open var dismissCompletion: ((UIViewController) -> Void)? = nil
    
    /// Show custom animation of closure.
    ///
    /// Set STZPopupShowAnimation.Custom to 'showAnimation' property to use custom animation.
    ///
    /// Argument:
    ///
    /// - containerView: Enclosing a popup view. Added to the view of UIViewController.
    /// - popupView: A popup view is displayed.
    /// - completion: Be sure to call after animation completion.
    open var showCustomAnimation: (UIView, UIView, (Void) -> Void) -> Void = { containerView, popupView, completion in }
    
    /// Dismiss custom animation of closure.
    ///
    /// Set STZPopupShowAnimation.Custom to 'dismissAnimation' property to use custom animation.
    ///
    /// Argument:
    ///
    /// - containerView: Enclosing a popup view. Added to the view of UIViewController.
    /// - popupView: A popup view is displayed.
    /// - completion: Be sure to call after animation completion.
    open var dismissCustomAnimation: (UIView, UIView, (Void) -> Void) -> Void = { containerView, popupView, completion in }
    
    public init() {}
}
