//
//  PWChainedRichMediaPresentingDelegate.m
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

#import "PWChainedRichMediaPresentingDelegate.h"

@interface PWChainedRichMediaPresentingDelegate () 

@property (nonatomic) NSMutableArray *queue;
@property (nonatomic) BOOL inAppIsPresenting;

@end

@implementation PWChainedRichMediaPresentingDelegate

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _queue = [NSMutableArray new];
    }
    
    return self;
}

- (BOOL)richMediaManager:(PWRichMediaManager *)richMediaManager shouldPresentRichMedia:(PWRichMedia *)richMedia {
    [_queue addObject:richMedia];
    return !_inAppIsPresenting;
}

- (void)richMediaManager:(PWRichMediaManager *)richMediaManager didPresentRichMedia:(PWRichMedia *)richMedia {
    _inAppIsPresenting = YES;
}

- (void)richMediaManager:(PWRichMediaManager *)richMediaManager didCloseRichMedia:(PWRichMedia *)richMedia {
    _inAppIsPresenting = NO;
    
    [_queue removeObject:richMedia];
    
    if (_queue.count) {
        [[PWRichMediaManager sharedManager] presentRichMedia:_queue.firstObject];
    }
}

- (void)richMediaManager:(PWRichMediaManager *)richMediaManager presentingDidFailForRichMedia:(PWRichMedia *)richMedia withError:(NSError *)error {
    [self richMediaManager:richMediaManager didCloseRichMedia:richMedia];
}

@end
