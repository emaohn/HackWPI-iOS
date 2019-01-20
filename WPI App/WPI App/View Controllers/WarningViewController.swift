//
//  WarningViewController.swift
//  WPI App
//
//  Created by Emmie Ohnuki on 1/19/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class WarningViewController: UIViewController {

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleWarning"), object: nil)
    }
}
