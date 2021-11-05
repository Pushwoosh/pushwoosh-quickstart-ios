//
//  ViewController.swift
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
import Pushwoosh.PWInbox
import PushwooshInboxUI

class ViewController: UIViewController {
    
    @IBOutlet weak var receivedInPushLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var addedLabel: UILabel!
    @IBOutlet weak var deletedLabel: UILabel!
    @IBOutlet weak var showInboxButton: UIButton!
    @IBOutlet weak var unreadInboxLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Pushwoosh Unread Inbox Messages
        countUnreadMessages()
        
        // Pushwoosh Inbox Messages Listener
        observerForUnreadMessages()
        
        // Pushwoosh Inbox Update Listener
        addObserverForUpdateInboxMessages()
        
        // Push observer for messages received in push notification
        addObserverForDidReceiveInPushNotification()
        
        unreadInboxLabel.layer.masksToBounds = true
        unreadInboxLabel.layer.cornerRadius = 15
        unreadInboxLabel.backgroundColor = .red
        unreadInboxLabel.textAlignment = .center
        unreadInboxLabel.text = "0"
        unreadInboxLabel.textColor = .white
        
        // Set User Id
        Pushwoosh.sharedInstance().setUserId("initialize@user")
    }

    // MARK: -
    // MARK: - Buttons Actions
    @IBAction func showInboxButtonAction(_ sender: Any) {
        // Customize inbox view controller and show it
        let style = PWIInboxStyle.default()
        
        let customInboxViewController = CustomInboxViewController.init(with: style!)
        let navigationViewController = UINavigationController.init(rootViewController: customInboxViewController)
        navigationViewController.navigationBar.backgroundColor = .white
        let cancelBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancelButtomActionOnPress))
        customInboxViewController.navigationItem.leftBarButtonItem = cancelBarButtonItem
        present(navigationViewController, animated: true, completion: nil)
    }
    
    @IBAction func loadMessagesButtonAction(_ sender: Any) {
        loadMessages()
    }
    
    @IBAction func changeUserButtonAction(_ sender: Any) {
        showAlertWithTextField()
    }
    
    @objc func cancelButtomActionOnPress () {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: -
    // MARK: - unreadMessagesCount
    func countUnreadMessages() {
        PWInbox.unreadMessagesCount { count, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            self.unreadInboxLabel.text = "0"
            self.unreadInboxLabel.text = "\(count)"
        }
    }

    // MARK: -
    // MARK: - addObserverForUnreadMessagesCount
    func observerForUnreadMessages() {
        PWInbox.addObserverForUnreadMessagesCount { count in
            if (count >= 0) {
                self.unreadInboxLabel.text = "0"
                self.unreadInboxLabel.text = "\(count)"
            }
        }
    }
    
    // MARK: -
    // MARK: - addObserverForUpdateInboxMessagesCompletion
    func addObserverForUpdateInboxMessages() {
        PWInbox.addObserver { messagesDeleted, messagesAdded, messagesUpdated in
            if let unwrappedMessagesDeleted = messagesDeleted {
                for message in unwrappedMessagesDeleted as [PWInboxMessageProtocol] {
                    self.deletedLabel.text = "Observer Deleted: \(message.message ?? "")"
                }
            }
            
            if let unwrappedMessagesAdded = messagesAdded {
                for message in unwrappedMessagesAdded as [PWInboxMessageProtocol] {
                    self.addedLabel.text = "Observer Added: \(message.message ?? "")"
                }
            }

            if let unwrappedMessagesUpdated = messagesUpdated {
                for message in unwrappedMessagesUpdated as [PWInboxMessageProtocol] {
                    self.updatedLabel.text = "Observer Updated: \(message.message ?? "")"
                }
            }
        }
    }
    
    // MARK: -
    // MARK: - addObserverForDidReceiveInPushNotificationCompletion
    func addObserverForDidReceiveInPushNotification() {
        PWInbox.addObserverForDidReceive { messagesAdded in
            if let unwrappedMessagesAdded = messagesAdded {
                for message in unwrappedMessagesAdded as [PWInboxMessageProtocol] {
                    self.receivedInPushLabel.text = "Did receive in push: \(message.message ?? "")"
                }
            }
        }
    }
    
    // MARK: -
    // MARK: - loadMessages
    func loadMessages() {
        PWInbox.loadMessages { messages, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            if let messages = messages {
                if let message = messages.first {
                    // Show information about last inbox message in array of inbox messages
                    self.showAlertWith(title: "Information", message: "message: \(message.message ?? "")\ntitle:\(message.title  ?? "")\ncode:\(message.code ?? "")\nimage URL:\(message.imageUrl ?? "No image URL")\nsend date:\(message.sendDate.toString(dateFormat: "dd-MM-YYYY") )\nis read:\(self.boolToString(boolValue: message.isRead))\nis action performed:\(self.boolToString(boolValue: message.isActionPerformed))\nattachment URL:\(message.attachmentUrl ?? "No attachment URL")\naction parameters:\(message.actionParams ?? ["": ""])")
                }
                if messages.count == 0 {
                    self.showAlertWith(title: "No Messages", message: "Messages count = \(messages.count)")
                }
            } else {
                print("Something went wrong")
            }
        }
    }

    // MARK: -
    // MARK: - updateInboxForNewUserId
    func updateInboxForNewUser(userId: String) {
        PWInbox.update { count in
            self.showAlertWith(title: "User ID changed", message: "For user \(userId) inbox messages = \(count)")
        }
    }
    
    
    // MARK: -
    // MARK: - Helpers
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showAlertWithTextField() {
        let alert = UIAlertController(title: "USER ID", message: "Enter new user ID. (updates observers for new userID)", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Set", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            Pushwoosh.sharedInstance().setUserId(textField?.text) { error in
                self.updateInboxForNewUser(userId: textField?.text ?? "000000")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func boolToString(boolValue: Bool) -> String {
        return boolValue ? "true" : "false"
    }
    
}

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
