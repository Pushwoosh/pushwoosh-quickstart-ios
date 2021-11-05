//
//  RichMediaQueueViewController.swift
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

class RichMediaQueueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PWRichMediaManager.shared().delegate = ChainedRichMediaPresentingDelegate.init(queue: [], inApp: false)
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

/*
 In case there are several Rich Media pages to display simultaneously (for example, trigger events for two or more In-Apps take place at one moment, or a Rich Media page is being displayed already at the moment a different trigger event occurs), you can set up a queue for Rich Media pages displaying. To create a queue, follow the steps described below.
 
 1. Create a class which implements PWRichMediaPresentingDelegate
 
 2. Set the delegate
 [PWRichMediaManager sharedManager].delegate = [ChainedRichMediaPresentingDelegate new];
 
 */
