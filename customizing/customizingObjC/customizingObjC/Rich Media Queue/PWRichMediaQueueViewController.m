//
//  PWRichMediaQueueViewController.m
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

#import "PWRichMediaQueueViewController.h"
#import "PWChainedRichMediaPresentingDelegate.h"

@interface PWRichMediaQueueViewController ()

@end

@implementation PWRichMediaQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PWChainedRichMediaPresentingDelegate * delegate = [[PWChainedRichMediaPresentingDelegate alloc] init];
    [[PWRichMediaManager sharedManager] setDelegate:delegate];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

/*
 
 In case there are several Rich Media pages to display simultaneously (for example, trigger events for two or more In-Apps take place at one moment, or a Rich Media page is being displayed already at the moment a different trigger event occurs), you can set up a queue for Rich Media pages displaying. To create a queue, follow the steps described below.
 
 1. Create a class which implements PWRichMediaPresentingDelegate
 
 2. Set the delegate
 [PWRichMediaManager sharedManager].delegate = [ChainedRichMediaPresentingDelegate new];
 
 */
