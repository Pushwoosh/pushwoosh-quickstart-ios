//
//  BViewController.swift
//  newdemo
//
//  Created by André Kis on 30.07.24.
//

import UIKit

class BViewController: UIViewController {
    
    @IBOutlet weak var titleLabelB: UILabel!
    
    var discountB: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        
        if discountB != nil {
            self.titleLabelB?.text = "\(discountB!) %"
        }
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
