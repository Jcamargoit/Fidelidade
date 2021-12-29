//
//  AppDelegate.swift
//  Fidelidade
//
//  Created by Juninho on 14/12/21.
//

import UIKit
//Push notification Perrmissão (AppDelegate)
import UserNotifications

//complemento da função de abrir tela especifica
//enum Identifiers {
//  static let viewAction = "VIEW_IDENTIFIER"
//  static let newsCategory = "NEWS_CATEGORY"
//}

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        //Push notification Perrmissão (AppDelegate)
        func registerForPushNotifications() {
          UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
              print("Permission granted: \(granted)")
              guard granted else { return }
                
                //Função para abrir notificação em uma tela especifica.
//              let viewAction = UNNotificationAction(
//                identifier: Identifiers.viewAction,
//                title: "View",
//                options: [.foreground])
//              let newsCategory = UNNotificationCategory(
//                identifier: Identifiers.newsCategory,
//                actions: [viewAction],
//                intentIdentifiers: [],
//                options: []
//              )
//              UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
             // self?.getNotificationSettings()
            }
        }
        
        //Push notification Perrmissão (AppDelegate)
        func getNotificationSettings() {
            UNUserNotificationCenter.current().getNotificationSettings {settings in
                print ("Configurações de notificação: \(settings)")
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            }
        }
        

        //Push notification Perrmissão (AppDelegate) Final de tudo
        //Em caso positivo estamos guardando o token do aparelho
        func application(
            _ application: UIApplication,
            didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
            let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
            let token = tokenParts.joined()
            print("Device Token: \(token)")
        }
        
        //Push notification Perrmissão (AppDelegate) Final de tudo
        //quando o metodo registerForPushNotifications() falha
        func application(
            _ application: UIApplication,
            didFailToRegisterForRemoteNotificationsWithError error: Error
        ) {
            print("Failed to register: \(error)")
        }
        
//
//        // Check if launched from notification
//        let notificationOption = launchOptions?[.remoteNotification]
//
//        // 1
//        if let notification = notificationOption as? [String: AnyObject],
//         let aps = notification["aps"] as? [String: AnyObject] {
//
//         ​NewsItem.makeNewsItem(aps)
//
//         ​(window?.rootViewController as? UITabBarController)?.selectedIndex = 1
//        }
        
        
        //Push notification Perrmissão (AppDelegate) Antes do return
        registerForPushNotifications()
        
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

