//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by André Kis on 18.11.25.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    var label: UILabel?

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        self.view = view
        self.label = label
    }

    func didReceive(_ notification: UNNotification) {
        PushwooshContentExtensionHelper.handleContentExtension(
            request: notification.request,
            in: self
        ) { success in
            if !success {
                self.label?.text = notification.request.content.body
            }
        }
    }
}
