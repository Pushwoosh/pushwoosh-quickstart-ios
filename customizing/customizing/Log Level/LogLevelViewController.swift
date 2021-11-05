//
//  LogLevelViewController.swift
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

class LogLevelViewController: UIViewController {

    @IBOutlet weak var textViewCustom: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentLogLevel = Bundle.main.object(forInfoDictionaryKey: "Pushwoosh_LOG_LEVEL") as? String

        textViewCustom.text = "To assist with debugging and integration, SDK will print all requests to the console by default. When you are ready for the production build, set 'Pushwoosh_LOG_LEVEL' string key in your Info.plist file to one of the following values, depending on how much you want to see: \n\nNONE - No logs from SDK\nERROR - Only display errors in console\nWARNING - Also display warnings\nINFO - Add informational messages\nDEBUG - Add debug information\nVERBOSE - Everything SDK can print and more. \n\nCurrent Log Level (info.plist): \(currentLogLevel!)"
        textViewCustom.font = UIFont.systemFont(ofSize: 15)
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

/*
 To assist with debugging and integration, SDK will print all requests to the console by default. When you are ready for the production build, set "Pushwoosh_LOG_LEVEL" string key in your Info.plist file to one of the following values, depending on how much you want to see:
 
 NONE - No logs from SDK
 ERROR - Only display errors in console
 WARNING - Also display warnings
 INFO - Add informational messages
 DEBUG - Add debug information
 VERBOSE - Everything SDK can print and more
 
 */
