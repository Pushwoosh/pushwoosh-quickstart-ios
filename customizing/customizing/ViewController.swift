//
//  ViewController.swift
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
import Pushwoosh

class ViewController: UIViewController {
    
    @IBOutlet weak var foregroundAlertSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show foreground alert
        foregroundAlertSwitch.addTarget(self, action: #selector(valueChange), for: UIControl.Event.valueChanged)
    }

    @objc func valueChange(foregroundAlertSwitch: UISwitch) {
        Pushwoosh.sharedInstance().showPushnotificationAlert = foregroundAlertSwitch.isOn
        
        /*
         By default our latest iOS SDK displays the notification banner when the app is running in the foreground.
         You can control this behavior by changing the following flags in the Info.plist:
         
         Flag Pushwoosh_ALERT_TYPE – string type, values are:
         
         BANNER – default value, displays banner in-app alert
         ALERT – alert notification
         NONE – do not show notifications when the app is in the foreground
         */
    }
    
    @IBAction func logLevelButtonAction(_ sender: Any) {
        openViewController(with: "log_level")
    }
    
    @IBAction func inAppTrackingButtonAction(_ sender: Any) {
        openViewController(with: "in_app")
    }
    
    @IBAction func geozonesButtonAction(_ sender: Any) {
        openViewController(with: "geozones")
    }
    
    @IBAction func richMediaButtonAction(_ sender: Any) {
        openViewController(with: "rich_media")
    }
    
    @IBAction func customNotificationCenterDelegateButtonAction(_ sender: Any) {
        openViewController(with: "notification_delegate")
    }
    
    func openViewController(with identifier: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        self.present(newViewController, animated: true, completion: nil)
    }
    
}

