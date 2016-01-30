//
//  AppDelegate.swift
//  Project1-FlickM
//
//  Created by Monte's Pro 13" on 1/16/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //   UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //   UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        //Now Playing tab bar button 1
        let nowPlayingNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! CollectionViewController
        nowPlayingViewController.endPoint = "now_playing"
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        nowPlayingNavigationController.tabBarItem.image = UIImage(named: "nowPlaying")
        
        //Customize Now Playing navigation bar UI
        nowPlayingNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        nowPlayingNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        nowPlayingNavigationController.navigationBar.topItem?.title = "Now Playing"
        
        
        
    
        //Top Rated tab bar button 2
        let topRatedNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavigationController.topViewController as! CollectionViewController
        topRatedViewController.endPoint = "top_rated"
        topRatedNavigationController.tabBarItem.title = "Top Rated"
        topRatedNavigationController.tabBarItem.image = UIImage(named: "topRated")
        
        //Customize Top Rated navigation bar UI
        topRatedNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        topRatedNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        topRatedNavigationController.navigationBar.topItem?.title = "Top Rated"
        
        
        
        
        
        //Popular tab bar button 3
        let popularNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let popularViewController = popularNavigationController.topViewController as! CollectionViewController
        popularViewController.endPoint = "popular"
        popularNavigationController.tabBarItem.title = "Popular"
        popularNavigationController.tabBarItem.image = UIImage(named: "popular")
        
        //Customize Popular navigation bar UI
        popularNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        popularNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        popularNavigationController.navigationBar.topItem?.title = "Popular"
        
        
        
        
        
        
        //Upcoming tab bar button 4
        let upcomingNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let upcomingViewController = upcomingNavigationController.topViewController as! CollectionViewController
        upcomingViewController.endPoint = "upcoming"
        upcomingNavigationController.tabBarItem.title = "Upcoming"
        upcomingNavigationController.tabBarItem.image = UIImage(named: "upcoming")

        
        //Customize Upcoming navigation bar UI
        upcomingNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        upcomingNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        upcomingNavigationController.navigationBar.topItem?.title = "Upcoming"
        
        
        
        
        //setup tabbar controller - add tab bar buttons
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [popularNavigationController, topRatedNavigationController, nowPlayingNavigationController, upcomingNavigationController]
        UITabBar.appearance().tintColor = UIColor.redColor()
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}

