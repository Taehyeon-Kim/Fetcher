//
//  AppDelegate.swift
//  Fetcher
//
//  Created by taekki on 2023/06/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    let viewController = ViewController()
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    return true
  }
}
