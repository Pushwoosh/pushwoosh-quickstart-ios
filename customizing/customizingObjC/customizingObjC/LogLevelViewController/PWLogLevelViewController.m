//
//  PWLogLevelViewController.m
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

#import "PWLogLevelViewController.h"

@interface PWLogLevelViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textViewCustom;

@end

@implementation PWLogLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * currentLogLevel = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Pushwoosh_LOG_LEVEL"];
    
    self.textViewCustom.text = [NSString stringWithFormat:@"To assist with debugging and integration, SDK will print all requests to the console by default. When you are ready for the production build, set 'Pushwoosh_LOG_LEVEL' string key in your Info.plist file to one of the following values, depending on how much you want to see: \n\nNONE - No logs from SDK\nERROR - Only display errors in console\nWARNING - Also display warnings\nINFO - Add informational messages\nDEBUG - Add debug information\nVERBOSE - Everything SDK can print and more. \n\nCurrent Log Level (info.plist): %@", currentLogLevel];
    [self.textViewCustom setFont:[UIFont systemFontOfSize:15]];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

/*
 To assist with debugging and integration, SDK will print all requests to the console by default. When you are ready for the production build, set "Pushwoosh_LOG_LEVEL" string key in your Info.plist file to one of the following values, depending on how much you want to see:
 
 NONE - No logs from SDK
 ERROR - Only display errors in console
 WARNING - Also display warnings
 INFO - Add informational messages
 DEBUG - Add debug information
 VERBOSE - Everything SDK can print and more
 
 */
