# SLPopupViewController

[![Pod Version](http://img.shields.io/cocoapods/v/SLPopupViewController.svg?style=flat)](http://cocoadocs.org/docsets/SLPopupViewController/)
[![Pod Platform](http://img.shields.io/cocoapods/p/SLPopupViewController.svg?style=flat)](http://cocoadocs.org/docsets/SLPopupViewController/)
[![Pod License](http://img.shields.io/cocoapods/l/SLPopupViewController.svg?style=flat)](http://opensource.org/licenses/Apache-2.0)

This library is used for showing popupViewController. Compatible with swift 2.0, iOS 9

###SLPopupViewController

A UIViewController Category to display a ViewController as a popup with different transition effects.
Written by Nguyen Duc Hoang, September 2015.

##Installation
### CocoaPods

Install with [CocoaPods](http://cocoapods.org) by adding the following to your Podfile:

####Objective-C

``` ruby
platform :ios, '8.0'
pod 'SLPopupViewController', '~> 1.0.0'
```
####Swift

``` ruby
platform :ios, '8.0'
use_frameworks!
pod 'SLPopupViewController', '~> 1.0.0'
```

**Note**: We follow http://semver.org for versioning the public API.

### Manually

Open in Xcode7 SWIFT project. Also you need to add the QuartzCore-Framework to your project.

##Usage

First you have to import the category

Simply use presentPopupViewController:animationType, f.e.:

let myPopupViewController:MyPopupViewController = MyPopupViewController(nibName:"MyPopupViewController", bundle: nil)
myPopupViewController.delegate = self
self.presentpopupViewController(myPopupViewController, animationType: animationType, completion: { () -> Void in
})
        
to dismiss the popup, use dismissPopupViewControllerWithanimationType

self.dismissPopupViewController(.Fade)
see the demo for more detailed examples

##Demo

You can open the SLPopupViewControllerDemo demo project in Xcode and run it on your iPhone as well as in the Simulator.
![iPhone Portrait](/assets/pic2.png?raw=true)

##Collaboration

Feel free to collaborate with ideas, issues and/or pull requests.

##License

SLPopupViewController is available under the Apache 2.0 license. See [the license file](LICENSE.md) for more info.
