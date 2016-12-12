//
//  AppDelegate.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 9/26/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        configureNotifications()
        return true
    }
    
    private func configureNotifications() {
        let uNNotificationCenter = UNUserNotificationCenter.current()
        let viewSaleAction = UNNotificationAction(identifier: APINotification.ViewSaleActionIdentifier, title: "Purchase", options: .foreground)
        let unsubscribeAction = UNNotificationAction(identifier: APINotification.UnsubscribeActionIdentifier, title: "Ignore", options: .destructive)
        let saleCategory = UNNotificationCategory(identifier: APINotification.SaleActionsCategoryIdentifier, actions: [viewSaleAction, unsubscribeAction],
                                                  intentIdentifiers: [], options: [.customDismissAction])
        uNNotificationCenter.setNotificationCategories([saleCategory])
        uNNotificationCenter.delegate = self
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        handleNotification(response: response)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    private func handleNotification(response: UNNotificationResponse) {
        if response.actionIdentifier == APINotification.UnsubscribeActionIdentifier {
            let mercName = response.notification.request.identifier
            API.unsubscribeFromMerchantWith(name: mercName)
        } else if response.actionIdentifier == APINotification.ViewSaleActionIdentifier {
            let mercName = response.notification.request.identifier
            print ("Merc name go to sale : \(mercName)")
            let merchant = API.getMerchantWith(name: mercName)
            let alertController = UIAlertController(title: "Sale purchased!", message: "Thanks for your purchase. Expect delivery in the next 24 hours",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                 merchant?.sold = true
            })
            
            window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

}

