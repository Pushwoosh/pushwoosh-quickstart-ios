//
//  ViewController.swift
//  newdemo
//
//  Created by André Kis on 29.07.24.
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
    
    let a = "A"
    let b = "B"
            
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
    }
    
    func setViewBackgroundColor(red: String, green: String, blue: String, discount: String) {
        let red = CGFloat((red as NSString).floatValue)
        let green = CGFloat((green as NSString).floatValue)
        let blue = CGFloat((blue as NSString).floatValue)
        
        let color = UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)

        if let topController = UIApplication.shared.topMostController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let customViewController = storyboard.instantiateViewController(withIdentifier: "custom_page") as? CustomPageViewController {
                customViewController.discount = discount
                customViewController.bgColor = color
                topController.present(customViewController, animated: true, completion: nil)
            }
        }
    }
    
    func setControllerA() {
        if let topController = UIApplication.shared.topMostController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let customViewController = storyboard.instantiateViewController(withIdentifier: "a_vc") as? AViewController {
                customViewController.discountA = "50"
                topController.present(customViewController, animated: true, completion: nil)
            }
        }
    }
    
    func setControllerB() {
        if let topController = UIApplication.shared.topMostController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let customViewController = storyboard.instantiateViewController(withIdentifier: "b_vc") as? BViewController {
                customViewController.discountB = "100"
                topController.present(customViewController, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: PWMessagingDelegate {
    
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        
        // MARK: - Open Custom View Controller and pass Data
        // MARK: - Uncomment if you want to test
//        guard let customDataJson = message.customData,
//              let redString = customDataJson["r"] as? String,
//              let greenString = customDataJson["g"] as? String,
//              let blueString = customDataJson["b"] as? String,
//              let discount = customDataJson["d"] as? String else {
//            return
//        }
//        
//        setViewBackgroundColor(red: redString, green: greenString, blue: blueString, discount: discount)
        
        // MARK: - A/B Testing via Custom Data
        // MARK: - Uncomment if you want to test
//        guard let customDataJson = message.customData,
//              let viewController = customDataJson["vc"] as? String else {
//            return
//        }
//        
//        if viewController == a {
//            setControllerA()
//        } else if viewController == b {
//            setControllerB()
//        }
        
        // MARK: - Change the app icon dynamically
        guard let customDataJson = message.customData,
              let appIcon = customDataJson["i"] as? String else {
                  return
              }
        
        UIApplication.shared.setAlternateIconName(appIcon) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        }
    }

    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        /**
         Tells the delegate that the application has received a remote notification.
         */
    }
}

extension UIApplication {
    func topMostController() -> UIViewController? {
        guard let keyWindow = self.connectedScenes
                // MARK: - Chooce your 'activationState' for testing
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return nil
        }

        var topController = keyWindow.rootViewController

        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }

        return topController
    }
}

