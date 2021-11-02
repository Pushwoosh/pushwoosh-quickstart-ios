//
//  AppDelegate.m
//  voippushesObjC
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

#import "AppDelegate.h"

#import <PushKit/PushKit.h>
#import <Pushwoosh/Pushwoosh.h>

@interface AppDelegate () <PWMessagingDelegate, PKPushRegistryDelegate>

@property (nonatomic, strong) PKPushRegistry* voipRegistry;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //-----------PUSHWOOSH PART-----------

    // set custom delegate for push handling, in our case AppDelegate
    [Pushwoosh sharedInstance].delegate = self;
    
    // handling push on app start
    [[Pushwoosh sharedInstance] handlePushReceived:launchOptions];
     
    // register for push notifications!
    [[Pushwoosh sharedInstance] registerForPushNotifications];
     
    _voipRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    _voipRegistry.delegate = self;
    _voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
    return YES;
}

- (void)pushRegistry:(PKPushRegistry *)registry didInvalidatePushTokenForType:(NSString *)type {
    //unsubscribe from push notifications
    [[Pushwoosh sharedInstance] unregisterForPushNotifications];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type withCompletionHandler:(void (^)(void))completion {
    //push received
    [[Pushwoosh sharedInstance] handlePushReceived:payload.dictionaryPayload];
}
 
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type {
    [[Pushwoosh sharedInstance] handlePushRegistration:credentials.token];
}

#pragma mark -
#pragma mark - PWMessagingDelegate

//handle token received from APNS
- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[Pushwoosh sharedInstance] handlePushRegistration:deviceToken];
}

//handle token receiving error
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[Pushwoosh sharedInstance] handlePushRegistrationFailure:error];
}

//this is for iOS < 10 and for silent push notifications
- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
          fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
        [[Pushwoosh sharedInstance] handlePushReceived:userInfo];
        completionHandler(UIBackgroundFetchResultNoData);
}

//this event is fired when the push gets received
- (void)pushwoosh:(Pushwoosh *)pushwoosh onMessageReceived:(PWMessage *)message {
    NSLog(@"onMessageReceived: %@", message.payload);
}

//this event is fired when a user taps the notification
- (void)pushwoosh:(Pushwoosh *)pushwoosh onMessageOpened:(PWMessage *)message {
    NSLog(@"onMessageOpened: %@", message.payload);
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end


