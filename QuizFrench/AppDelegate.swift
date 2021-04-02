//
//  AppDelegate.swift
//  QuizFrench
//
//  Created by Rio Abe on 2020/08/03.
//  Copyright © 2020 Rio Abe. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //DB接続
        let applicationKey = "e55a2eac3f4474e7bec9792e45aa90b1f93c519b5b0a858130afa329203c0fcc"
        let clientKey = "f11174dd8cf3b3a1f806fb48653217f9cd9366313c719b14983853c71d123985"
        
        NCMB.setApplicationKey(applicationKey, clientKey: clientKey)
        
        //匿名認証　anonymous.idをUserDEfaultsに保存
        NCMBAnonymousUtils.logIn { (user, error) in
            if error != nil {
                print("Log in failed")
                print(error ?? "")
            } else {
                print("Logged in")
                let authData = user!.object(forKey: "authData") as! [String: Any]
                let uuid = (authData["anonymous"] as! [String: String]) ["id"]
                UserDefaults.standard.set(uuid,forKey: "uuid")
            }
        }
        //IDを使って認証する
        let uuid = UserDefaults.standard.string(forKey: "uuid")
        
        let user = NCMBUser.init()
        let anonymousDic = ["anonymous": ["id": uuid]]
        user.setObject(anonymousDic, forKey: "authData")
        user.signUpInBackground({ (error) in
            if error != nil {
                print("Error")
            } else {
                print("Log in")
            }
        })
        
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

