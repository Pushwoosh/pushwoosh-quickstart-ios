//
//  CustomNotificationCDViewConrtoller.swift
//  customizing
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

class CustomNotificationCDViewConrtoller: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        Pushwoosh.sharedInstance().notificationCenterDelegateProxy.add(self)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if (!PWMessage.isPushwooshMessage(notification.request.content.userInfo)) {
            //handle your message
            completionHandler(.alert)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if (!PWMessage.isPushwooshMessage(response.notification.request.content.userInfo)) {
            //handle your message
            completionHandler()
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

/*
 If you want to use your own UNNotificationCenterDelegate (for example, for local notifications), you should inform Pushwoosh SDK about it for proper behavior. You can do it with the notificationCenterDelegateProxy property of Pushwoosh instance:
 
 Pushwoosh.sharedInstance()?.notificationCenterDelegateProxy.add(my_delegate) (swift)
 
 [Pushwoosh.sharedInstance.notificationCenterDelegateProxy addNotificationCenterDelegate:my_delegate]; (Objective-C)
 
 Then, implement UNNotificationCenterDelegate methods in your delegate:
 
 func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
     if (!PWMessage.isPushwooshMessage(notification.request.content.userInfo)) {
         // handle your notification
         completionHandler(UNNotificationPresentationOptions.alert)
     }
 }

 func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
     if (!PWMessage.isPushwooshMessage(response.notification.request.content.userInfo)) {
         // handle your notification
         completionHandler()
     }
 }
 (swift)
 
 - (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
     if (![PWMessage isPushwooshMessage:notification.request.content.userInfo]) {
         //handle your message
         completionHandler(UNNotificationPresentationOptionAlert);
     }
 }

 - (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
     if (![PWMessage isPushwooshMessage:response.notification.request.content.userInfo]) {
         //handle your message
         completionHandler();
     }
 }
 
 (Objective-C)
 */
