//
//  AppDelegate.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let managedObjectContext = createPomodoroMainContext()
    
//    let managedObjectContext = createBoardsMainContext()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        

        // checks if app has user key for trello api
//        let defaults = NSUserDefaults.standardUserDefaults()
//        if defaults.boolForKey(Constants.hasUserToken) == false {
//            let welcomeViewContoller = storyboard.instantiateViewControllerWithIdentifier(StoryBoard.welcomeViewControllerIdentifier) as! WelcomeViewController
//            self.window!.rootViewController = welcomeViewContoller
//            welcomeViewContoller.managedObjectContext = managedObjectContext
//        } else {
//            let mainViewController = storyboard.instantiateViewControllerWithIdentifier(StoryBoard.trelloViewControllerIdentifier) as! TrelloTableViewController
//            mainViewController.managedObjectContext = managedObjectContext
//            let navCon = UINavigationController(rootViewController: mainViewController)
//            self.window!.rootViewController = navCon
//        }
        
//        self.window!.makeKeyAndVisible()

        
        guard let vc = window?.rootViewController?.contentViewController as? ManagedObjectContextSettable else {
            fatalError("Wrong view controller type")
        }
        vc.managedObjectContext = managedObjectContext
        
        let tabCon = UITabBarController()

        window!.rootViewController!.tabBarItem = UITabBarItem(title: "Tasks", image: nil, tag: 0)
        let settingsCon = SettingsTableViewController()
        settingsCon.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        
        tabCon.setViewControllers([window!.rootViewController!, settingsCon], animated: true)
        
        window?.rootViewController = tabCon
        
        return true
    }
}

