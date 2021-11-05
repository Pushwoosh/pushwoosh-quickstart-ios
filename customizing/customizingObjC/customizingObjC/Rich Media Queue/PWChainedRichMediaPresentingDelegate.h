//
//  PWChainedRichMediaPresentingDelegate.h
//  customizingObjC
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

#import <Foundation/Foundation.h>
#import <Pushwoosh/PWRichMediaManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWChainedRichMediaPresentingDelegate : NSObject <PWRichMediaPresentingDelegate>

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
