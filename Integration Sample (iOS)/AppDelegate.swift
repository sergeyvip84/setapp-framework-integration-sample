//
//  AppDelegate.swift
//  Integration Sample (iOS)
//
//  Created by Сергій Попов on 16.06.2025.
//

import UIKit
import Setapp

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    class AppDelegate: UIResponder, UIApplicationDelegate {

        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
            
            let config = SetappConfiguration(
                publicKeyBundle: .main,
                publicKeyFilename: "setappPublicKey-IOS.pem"
            )
            
            SetappManager.shared.start(with: config)
            
            return true
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

class SetappSubscriptionManagerDelegate: SetappManagerDelegate {
  init() {
    SetappManager.shared.delegate = self
  }
  // MARK: SetappManagerDelegate
  func setappManager(
    _ manager: SetappManager,
    didUpdateSubscriptionTo newSetappSubscription: SetappSubscription
  )
  {
    print("Manager:", manager)
    print("Setapp subscription:", newSetappSubscription)
  }
}

class SetappSubscriptionNotificationObserver {
  private var notificationObserver: NSObjectProtocol?
  init() {
    notificationObserver = NotificationCenter.default
      .addObserver(forName: SetappManager.didChangeSubscriptionNotification,
                   object: SetappManager.shared,
                   queue: .none) { [weak self] (notification) in
                    self?.setappSubscriptionDidChange(notification: notification)
    }
  }
  deinit {
    notificationObserver.map(NotificationCenter.default.removeObserver(_:))
  }
  // MARK: Notification
  func setappSubscriptionDidChange(notification: Notification) {
    guard
      let manager = notification.object as? SetappManager,
      let newValue = notification.userInfo?[NSKeyValueChangeKey.newKey],
      let newSetappSubscription = newValue as? SetappSubscription else {
        return
    }
    print("Manager:", manager)
    print("Setapp subscription:", newSetappSubscription)
  }
}


