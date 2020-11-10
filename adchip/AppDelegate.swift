//
//  AppDelegate.swift
//  adchip
//
//  Created by 野中志保 on 2020/08/27.
//  Copyright © 2020 野中志保. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if Auth.auth().currentUser != nil {
            let homeVC = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
            navigationController = UINavigationController(rootViewController: homeVC)
            window?.rootViewController = navigationController
        } else {
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as UIViewController
            navigationController = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
        
        // 通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .sound, .badge]){
            (granted, _) in
            if granted{
                UNUserNotificationCenter.current().delegate = self
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    // coredata
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.userInfo)
            }
        })
        return container
    }()
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // アプリ起動中でもアラートと音で通知
        completionHandler([.alert, .sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        
    }
}

