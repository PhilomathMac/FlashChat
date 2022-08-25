# FlashChat

<p align="center">
  <img src="https://github.com/PhilomathMac/FlashChat/blob/main/PortfolioImage.png?raw=true" alt="FlashChat Screenshot" width="100%"/>
</p>

## Description
A simple messaging app that uses a Firebase database to store and retrieve user messages in the cloud.

## Skills Practiced

* SPM (Swift Package Manager)
* Cocoapods
* Firebase Firestore
* Querying a Database
* User Authentication
* UITableView
* Delegate and Protocol Pattern
* .xib Files
* Animations Using Loops
* App Life Cycle Methods
* Segues

## Future Features / Fixes
* Add time and date under each chat message [helpful link](https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/18002985#questions/13254672)
* Implement forgot password [helpful link](https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/18002985#questions/13254672)
* Implement secure password validation
* Fix navBar appearance 

Code to Try:
```swift
fileprivate func setNavigtionBarItems() {
 
    if #available(iOS 13.0, *) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = myBackgroundColor
 
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        //navigationController?.navigationBar.compactAppearance = appearance
 
    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = myBackgroundColor
    }
```

```swift
import UIKit
struct NavigationDesign {
    func navigationSetting(naviController: UIViewController){
        let theColourWeAreUsing = UIColor.white
        let contrastColour = UIColor.systemGray
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.backgroundColor = theColourWeAreUsing
        naviController.navigationItem.standardAppearance = navBarAppearance
        naviController.navigationItem.scrollEdgeAppearance = navBarAppearance
    }
}
 
//then you can call this function in every view controller as below
//someUIViewController is your current uiviewcontroller
NavigationDesign().navigationSetting(naviController: someUIViewController)
```

```swift
/*
You may have noticed even the completed project has a bug in it if you are on Xcode 11.4 (or possible numbers above this).
The NavBar title on the chat viewcontroller is black and does not take on the white colour which is set in the inspector as it did in previous versions of Xcode.  This appears to be a bug in Xcode but here is the fix.
Add these lines to your app delegate in the didFinishLaunchingWithOptions method.
*/
if #available(iOS 13.0, *) {
let appearance = UINavigationBarAppearance()
appearance.titleTextAttributes = [
NSAttributedString.Key.foregroundColor: UIColor.white]
appearance.largeTitleTextAttributes = [
NSAttributedString.Key.foregroundColor: UIColor.white]
UINavigationBar.appearance().barTintColor = UIColor(named: K.BrandColors.blue)
}
/*
Here is the background to the issue on stack overflow.
https://stackoverflow.com/questions/60848786/xcode-11-4-navigations-title-color-gone-black-from-storyboard

OR

If you have this problem too, change the Navigation Bar Tint to "Default" and this solve it, then in your AppDelegate.swift, inside the didFinishLaunchingWithOptions function put this:
*/
UINavigationBar.appearance().barTintColor = UIColor(named: K.BrandColors.blue)
```

## Use Instructions

This app uses a Firebase database. You'll need to set up your own Firebase database and add your own GoogleServices-Info.plist file to the project.

## Attributions

This was developed using ideas from The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)
