//
//  NotificationService.swift
//  NotificationService
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

import UserNotifications
import Pushwoosh

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        //MARK: -      |  |
        //MARK: -      |  |
        //MARK: -   ___|  |___
        //MARK: -   \        /
        //MARK: -    \      /
        //MARK: -     \    /
        //MARK: -      \  /
        //MARK: -       \/
        
        
        //MARK: - Pushwoosh Notification Service Extension Code for Message Delivery Event and setting up badges
        PWNotificationExtensionManager.shared().handle(request, contentHandler: contentHandler)
        /*
         Pushwoosh Notification Service Extension Code
         MARK: - 1 Add Pushwoosh_APPID to your Notification Service Extension info.plist.
         
         <key>Pushwoosh_APPID</key>
         <string>XXXXX-XXXXX</string>
         */
        
        //MARK: - 2. Add the App Groups capability for each target of your application
        //Add the App Groups ID to your info.plist for each target of your application:
        /*
         <key>PW_APP_GROUPS_NAME</key>
         <string>group.com.example.demoapp_example</string>
         
         If you do not want to use the info.plist file, use the method below and add the code to your NotificationServiceExtension class:
         
         @code
            PWNotificationExtensionManager.shared().handle(request, withAppGroups: "group.com.example.demoapp_example")
         @code
         */
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
