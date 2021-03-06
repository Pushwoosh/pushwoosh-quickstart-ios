//
//  ChainedRichMediaPresentingDelegate.swift
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

class ChainedRichMediaPresentingDelegate: NSObject, PWRichMediaPresentingDelegate {
    
    var queue: [PWRichMedia]
    var inAppIsPresenting: Bool
    
    init(queue: [PWRichMedia], inApp: Bool) {
        self.queue = queue
        self.inAppIsPresenting = inApp
        super.init() // can actually be omitted in this example because will happen automatically.
    }
    
    convenience override init() {
        self.init(queue: [], inApp: false)
    }
    
    func richMediaManager(_ richMediaManager: PWRichMediaManager!, shouldPresent richMedia: PWRichMedia!) -> Bool {
        queue.append(richMedia)
        return !inAppIsPresenting
    }
    
    func richMediaManager(_ richMediaManager: PWRichMediaManager!, didPresent richMedia: PWRichMedia!) {
        inAppIsPresenting = true
    }
    
    func richMediaManager(_ richMediaManager: PWRichMediaManager!, didClose richMedia: PWRichMedia!) {
        inAppIsPresenting = false
        
        if let idx = queue.firstIndex(where: { $0 === richMedia }) {
            queue.remove(at: idx)
        }
        
        if ((queue.count) != 0) {
            PWRichMediaManager.shared().present(queue.first)
        }
    }
    
    func richMediaManager(_ richMediaManager: PWRichMediaManager!, presentingDidFailFor richMedia: PWRichMedia!, withError error: Error!) {
        self.richMediaManager(richMediaManager, didClose: richMedia)
    }
}
