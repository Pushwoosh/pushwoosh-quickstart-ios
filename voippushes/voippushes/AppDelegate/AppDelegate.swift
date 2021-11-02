//
//  AppDelegate.swift
//  voippushes
//
//  Created by Pushwoosh
//
/*
 ******************************************************
 * CHANGE <Pushwoosh_APPID>                           *
 * VALUE IN THE INFO.PLIST FILE.                      *
 * REPLACE XXXXX-XXXXX WITH YOUR APP ID PROJECT CODE. *
 ******************************************************
 */

import UIKit
import Pushwoosh
import PushKit
import CallKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, PWMessagingDelegate, PKPushRegistryDelegate {
    

    let voipRegistry: PKPushRegistry = PKPushRegistry(queue: DispatchQueue.main)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // handling push on app start
        PushNotificationManager.push().handlePushReceived(launchOptions)

        // make sure we count app open in Pushwoosh stats
        PushNotificationManager.push().sendAppOpen()

        // register for push notifications!
        PushNotificationManager.push().registerForPushNotifications()

        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        
        //-----------PUSHWOOSH PART-----------
        //initialization code
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance()?.delegate = self;
        
        //register for push notifications
        Pushwoosh.sharedInstance()?.registerForPushNotifications()
        
        return true
    }
    
    // MARK: PKPushRegistryDelegate
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        PushNotificationManager.push().unregisterForPushNotifications { error in
            
        }
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        PushNotificationManager.push().handlePushReceived(payload.dictionaryPayload)
    }

    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for forType: PKPushType) {
        PushNotificationManager.push().handlePushRegistration(pushCredentials.token)
    }
    
    
    // MARK: PWMessagingDelegate
    
    //handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Pushwoosh.sharedInstance()?.handlePushRegistration(deviceToken)
    }
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance()?.handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance()?.handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh!, onMessageReceived message: PWMessage!) {
        print("onMessageReceived: ", message.payload.description)
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh!, onMessageOpened message: PWMessage!) {
        print("onMessageOpened: ", message.payload.description)
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

