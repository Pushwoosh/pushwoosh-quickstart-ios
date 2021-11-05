//
//  CustomInboxViewController.swift
//  inbox
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
import PushwooshInboxUI

class CustomInboxViewController: PWIInboxViewController {
    
    var style: PWIInboxStyle?
    
    init(with style: PWIInboxStyle) {
        super.init(nibName: nil, bundle: nil)
        
        self.style = style
        
        style.backgroundColor = .white
        style.listEmptyMessage = "No Messages"
        style.titleColor = .black
        style.readTitleColor = .gray
        style.readTextColor = .gray
        style.dateColor = .red
        style.barTitle = "Pushwoosh Inbox"
        style.barTextColor = UIColor(red: 20/255.0, green: 228/255.0, blue: 184/255.0, alpha: 1.0)
        style.unreadImage = UIImage.init(named: "envelope")
        
        PWIInboxUI.createInboxController(with: style)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.style = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
