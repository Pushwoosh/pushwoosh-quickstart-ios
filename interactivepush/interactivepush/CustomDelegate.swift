//
//  CustomDelegate.swift
//  interactivepush
//
//  Created by André Kis on 01.08.24.
//

import UIKit

class CustomDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        let category = response.notification.request.content.categoryIdentifier
        
        if category == "10212" {
            if identifier == "1" {
                // DO SOMEHTING
            } else {
                // DO SOMETHING ELSE
            }
        }
        
        completionHandler()
    }
}
