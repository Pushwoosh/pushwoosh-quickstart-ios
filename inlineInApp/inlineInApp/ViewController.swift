//
//  ViewController.swift
//  inlineInApp
//
//  Created by Andrew Kis on 8.5.24..
//

import UIKit
import Pushwoosh.PWInlineInAppView

class ViewController: UIViewController, PWInlineInAppViewDelegate {
    var inlineInAppView: PWInlineInAppView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let safe = self.view.safeAreaLayoutGuide
        
        showInlineInAppViewTop(safe: safe, constant: 50)
        showInlineInAppBottom(safe: safe, constant: -150)
    }
    
    func showInlineInAppViewTop(safe: UILayoutGuide, constant: CGFloat) {
        showInlineInApp(anchor: safe.topAnchor, constant: constant)
    }
    
    func showInlineInAppBottom(safe: UILayoutGuide, constant: CGFloat) {
        showInlineInApp(anchor: safe.bottomAnchor, constant: constant)
    }
    
    // Creating Inline In App
    // *******************************************************************
    func showInlineInApp(anchor: NSLayoutYAxisAnchor, constant: CGFloat) {
        inlineInAppView = PWInlineInAppView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        
        if let inlineInAppView = inlineInAppView {
            inlineInAppView.translatesAutoresizingMaskIntoConstraints = false
            inlineInAppView.delegate = self

            self.view.addSubview(inlineInAppView)

            let safe = self.view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                inlineInAppView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
                inlineInAppView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
                inlineInAppView.topAnchor.constraint(equalTo: anchor, constant: constant)
            ])

            inlineInAppView.identifier = "inlineInApp"
        }
    }
    // *******************************************************************
    
    @IBAction func showAlertAction(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Pushwoosh", message: "Hello, Pushwoosh!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
