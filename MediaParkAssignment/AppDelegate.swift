//
//  AppDelegate.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 1/2/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    application.setupAppearances()
    
    let vc = UIStoryboard.main().instantiate(controller: MainViewController.self)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
    
    return true
  }
}

