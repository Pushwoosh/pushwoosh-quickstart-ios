//
//  GeozonesViewController.swift
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
import PushwooshGeozones

class GeozonesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Start Geozones tracking when needed
        PWGeozonesManager.shared().startLocationTracking()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}

/*
 Gezones push notifications are encapsulated into a separate framework PushwooshGeozones.
 
 1. To add PushwooshGeozones.framework to your project using a dependency manager, put the following lines in your podfile or cartfile:
 
 pod 'Pushwoosh/Geozones' (Podfile)
 github "Pushwoosh/pushwoosh-ios-sdk" (Cartfile)
 
 Also, you can simply drag and drop the framework into Link Binaries With Libraries in your project's Build Phases.
 
 2. Add the following keys to your Info.plist:
 
 * NSLocationWhenInUseUsageDescription – (required) for app to track Geozones only while running in the foreground.
 * NSLocationAlwaysAndWhenInUseUsageDescription - (required) for app to track Geozones in both conditions and to show a permission request dialog pop-up.
 * NSLocationAlwaysUsageDescription – (optional) for app to track Geozones at all times; should be used if your app targets iOS 10 and earlier versions.
 
 3. Import the framework:
 
 import PushwooshGeozones (swift)
 #import <PushwooshGeozones/PWGeozonesManager.h> (Objective-C)
 
 4. Start Geozones tracking when needed:
 
 PWGeozonesManager.shared()?.startLocationTracking() (swift)
 [[PWGeozonesManager sharedManager] startLocationTracking]; (Objective-C)
 
 */
