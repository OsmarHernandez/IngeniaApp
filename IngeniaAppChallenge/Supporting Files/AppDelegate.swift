//
//  AppDelegate.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = window!.rootViewController as! UINavigationController
        let mainViewController = rootViewController.topViewController as! GistsViewController
        mainViewController.store = GistStore()
        
        return true
    }
}

