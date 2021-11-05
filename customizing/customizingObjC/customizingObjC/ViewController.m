//
//  ViewController.m
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

#import "ViewController.h"

#import <Pushwoosh/Pushwoosh.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *foregroundAlertSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.foregroundAlertSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChange:(UISwitch *)switchState {
    [[Pushwoosh sharedInstance] setShowPushnotificationAlert:switchState.isOn];
    
    /*
     By default our latest iOS SDK displays the notification banner when the app is running in the foreground.
     You can control this behavior by changing the following flags in the Info.plist:
     
     Flag Pushwoosh_ALERT_TYPE – string type, values are:
     
     BANNER – default value, displays banner in-app alert
     ALERT – alert notification
     NONE – do not show notifications when the app is in the foreground
     */
}

- (IBAction)logLevelButtonAction:(id)sender {
    [self openViewControllerWithIdentifier:@"log_level"];
}

- (IBAction)inAppTrackingButtonAction:(id)sender {
    [self openViewControllerWithIdentifier:@"in_app"];
}

- (IBAction)geozonesButtonAction:(id)sender {
    [self openViewControllerWithIdentifier:@"geozones"];
}

- (IBAction)richMediaButtonAction:(id)sender {
    [self openViewControllerWithIdentifier:@"rich_media"];
}

- (IBAction)customNotificationCenterDelegateButtonAction:(id)sender {
    [self openViewControllerWithIdentifier:@"notification_delegate"];
}

- (void)openViewControllerWithIdentifier:(NSString *)identifier {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * newViewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [self presentViewController:newViewController animated:YES completion:nil];
}

@end
