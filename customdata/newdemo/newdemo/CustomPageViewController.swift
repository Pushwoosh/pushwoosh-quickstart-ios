//
//  CustomPageViewController.swift
//  newdemo
//
//  Created by André Kis on 30.07.24.
//
/*
 ******************************************************
 * CHANGE <Pushwoosh_APPID>                           *
 * VALUE IN THE INFO.PLIST FILE.                      *
 * REPLACE XXXXX-XXXXX WITH YOUR APP ID PROJECT CODE. *
 ******************************************************
 */

import UIKit

class CustomPageViewController: UIViewController {
    
    var bgColor: UIColor?
    var discount: String?

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = self.bgColor
        
        if self.discount != nil {
            self.titleLabel?.text = "ONLY TODAY GET \(self.discount!)% DISCOUNT!"
        }
    }
    
    func showPromoPage(discount: String) {
        let vc = CustomPageViewController()
        vc.bgColor = self.view.backgroundColor
        vc.discount = discount
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        if self.presentedViewController != nil {
            self.dismiss(animated: true, completion: {
                self.present(vc, animated: true, completion: nil)
            })
        } else {
            self.present(vc, animated: true, completion: nil)
        }
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
