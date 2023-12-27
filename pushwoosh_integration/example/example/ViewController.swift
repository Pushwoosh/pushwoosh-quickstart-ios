//
//  ViewController.swift
//  example
//
//  Created by Andrei Kiselev on 27.12.23..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "PUSHWOOSH"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.center = view.center
        label.transform = CGAffineTransform(rotationAngle: .pi)
        let scaleFactor: CGFloat = 1.5
        label.transform = label.transform.scaledBy(x: scaleFactor, y: scaleFactor)
        UIView.animate(withDuration: 1.0) {
            label.transform = .identity
        }
        view.addSubview(label)
    }


}

