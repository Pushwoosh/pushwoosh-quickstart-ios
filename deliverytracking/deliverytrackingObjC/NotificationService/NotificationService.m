//
//  NotificationService.m
//  NotificationService
//
//  Created by Kiselev Andrey on 22.10.2021.
//

#import "NotificationService.h"

#import <Pushwoosh/PWNotificationExtensionManager.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    
    /*
     There is an API method in Pushwoosh that tracks the delivery of push notifications. iOS apps do not support this method out of the box as push
     notifications in iOS are handled by the OS, not by Pushwoosh SDK. However, you can implement delivery tracking by adding the Pushwoosh
     Notification Service Extension for push delivery tracking to your project. Here you'll find the steps to implement Message Delivery Tracking
     for iOS apps.
     */
    
    //---------PUSHWOOSH PART---------
    [[PWNotificationExtensionManager sharedManager] handleNotificationRequest:request contentHandler:contentHandler];
    //--------------------------------
    
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
