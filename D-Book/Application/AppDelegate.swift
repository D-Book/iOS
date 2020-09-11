//
//  AppDelegate.swift
//  D-Book
//
//  Created by 강민석 on 2020/06/05.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        
        let isLogin = UserDefaults.standard.bool(forKey: "loginState")
        print("로그인 여부: \(isLogin)")
        
        if isLogin == true {
            let mainTabBarController = mainStoryboard.instantiateViewController(identifier: "MainTabBarController")
            window?.rootViewController = mainTabBarController
        } else {
            let loginViewController = loginStoryBoard.instantiateViewController(identifier: "LoginViewController")
            window?.rootViewController = loginViewController
        }
        
        return true
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }
    
    /* Go to main
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
     (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
     */
    
    /* Go to login
     let storyboard = UIStoryboard(name: "Login", bundle: nil)
     let loginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
     (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(loginViewController)
     */
    
    
}

