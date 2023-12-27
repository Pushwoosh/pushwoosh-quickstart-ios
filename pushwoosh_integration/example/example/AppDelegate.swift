//
//  AppDelegate.swift
//  example
//
//  Created by Andrei Kiselev on 27.12.23..
//
/*
 ******************************************************
 * CHANGE <Pushwoosh_APPID>                           *
 * VALUE IN THE INFO.PLIST FILE.                      *
 * REPLACE XXXXX-XXXXX WITH YOUR APP ID PROJECT CODE. *
 ******************************************************
 */

import UIKit
/*
 1. Add Required Capabilities
    1.1 Select the root project, your main app target, then go to the Signing and Capabilities tab.
    1.2 Press + Capability button and select the Push Notifications capability.
    1.3 Then, add the Background Modes capability and check the Remote notifications check box.
    1.4 Well done! Xcode capabilities configuration completed.
 2. Add the Pushwoosh Initialization code
    2.1 Add the following code to your AppDelegate class:
        |  |
        |  |
     ___|  |___
     \        /
      \      /
       \    /
        \  /
         \/
 */
import Pushwoosh
                                                    /*                         */
@main                                              /* Add PWMessagingDelegate */
                                                  /*                         */
class AppDelegate: UIResponder, UIApplicationDelegate, PWMessagingDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //initialization code
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance().delegate = self
        
        //register for push notifications
        Pushwoosh.sharedInstance().registerForPushNotifications()
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

//MARK: -      |  |
//MARK: -      |  |
//MARK: -   ___|  |___
//MARK: -   \        /
//MARK: -    \      /
//MARK: -     \    /
//MARK: -      \  /
//MARK: -       \/

extension AppDelegate {
    //handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        if let payload = message.payload {
            print("onMessageOpened: ", payload.description)
        }
    }
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        if let payload = message.payload {
            print("onMessageReceived: ", payload.description)
        }
    }
}

//MARK: -      |  |
//MARK: -      |  |
//MARK: -   ___|  |___
//MARK: -   \        /
//MARK: -    \      /
//MARK: -     \    /
//MARK: -      \  /
//MARK: -       \/

/*
// MARK: - 2.2 In your Info.plist, add a string type key Pushwoosh_APPID with your Pushwoosh Application Code as a value.
 
 <key>Pushwoosh_APPID</key>
 <string>XXXXX-XXXXX</string> - Replace XXXXX-XXXXX with your Pushwoosh APP ID
 
 
 //MARK: - SETTING UP BADGES
 //
 //MARK: -      |  |
 //MARK: -      |  |
 //MARK: -   ___|  |___
 //MARK: -   \        /
 //MARK: -    \      /
 //MARK: -     \    /
 //MARK: -      \  /
 //MARK: -       \/
 //
 //MARK: - OPEN NotificationService.swift file
 */

