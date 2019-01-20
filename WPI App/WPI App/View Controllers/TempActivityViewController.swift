//
//  TempActivityViewController.swift
//  WPI App
//
//  Created by Emmie Ohnuki on 1/19/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TempActivityViewController: UIViewController {
    @IBOutlet var overallView: UIView!
    @IBOutlet weak var statView: UIView!
    @IBOutlet weak var percentView: UIView!
    @IBOutlet weak var goalTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var percentToGoalLabel: UILabel!
    @IBOutlet weak var efficiencyPercentLabel: UILabel!
    @IBOutlet weak var goalProgressView: UIProgressView!
    @IBOutlet weak var efficiencyProgressView: UIProgressView!
    @IBOutlet weak var tempSetter: UIStepper!
    
    var stats: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadValues()
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadValues()
    }
    
    func reloadValues() {
        if let stats = self.stats {
            let tempGoal = stats["temperature_goal"] as! Double
            let currentTemp = stats["temperature"] as! Double
            tempSetter.value = tempGoal
            goalTempLabel.text = "\(tempGoal)"
            currentTempLabel.text = "\(currentTemp)"
            goalProgressView.progress = Float(currentTemp/tempGoal)
            efficiencyProgressView.progress = 0.6
            percentToGoalLabel.text = "\(currentTemp/tempGoal)%"
            efficiencyPercentLabel.text = "60%"
        }
    }
    
    func setup(){
        overallView.backgroundColor = UIColor.tcDarkBlue
        
//        statView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        statView.layer.shadowOpacity = 1
//        statView.layer.shadowOffset = CGSize.zero
//        statView.layer.shadowColor = UIColor.black.cgColor
//        statView.layer.shadowRadius = 15
//        statView.layer.cornerRadius = 8
//        statView.layer.masksToBounds = true
        statView.backgroundColor = UIColor.tcDarkBlue
        
//        percentView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        percentView.layer.shadowOpacity = 1
//        percentView.layer.shadowOffset = CGSize.zero
//        percentView.layer.shadowColor = UIColor.black.cgColor
//        percentView.layer.shadowRadius = 15
//        percentView.layer.cornerRadius = 8
//        percentView.layer.masksToBounds = true
        percentView.backgroundColor = UIColor.tcDarkBlue
        
        goalProgressView.layer.cornerRadius = 11
        goalProgressView.layer.masksToBounds = true
        
        efficiencyProgressView.layer.cornerRadius = 11
        efficiencyProgressView.layer.masksToBounds = true
    }

    @IBAction func tempSetterToggled(_ sender: UIStepper) {
        reloadValues()
    }
}
