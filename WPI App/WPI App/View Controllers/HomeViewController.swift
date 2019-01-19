//
//  HomeViewController.swift
//  SmartHome
//
//  Created by Emmie Ohnuki on 1/18/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doorSettingContainerView: UIView!
    @IBOutlet weak var doorContainerBottomConstraint: NSLayoutConstraint!
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDoorSettings), name: NSNotification.Name("ToggleDoorSettings"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setup(){
        doorSettingContainerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        doorSettingContainerView.layer.shadowOpacity = 1
        doorSettingContainerView.layer.shadowOffset = CGSize.zero
        doorSettingContainerView.layer.shadowColor = UIColor.black.cgColor
        doorSettingContainerView.layer.shadowRadius = 15
        doorSettingContainerView.layer.cornerRadius = 10
        doorSettingContainerView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: toggleDoorSettings()
        case 1: self.performSegue(withIdentifier: "openTempActivity", sender: self)
        //case 2: self.performSegue(withIdentifier: "openLightActivity", sender: self)
        //case 3: self.performSegue(withIdentifier: "openHomeActivity", sender: self)
        default: print("nothing")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Door State >"
            cell.statLabel.text = "OPEN"
            cell.iconImageView.image = UIImage(named: "lockicon.png")
        case 1:
            cell.titleLabel.text = "Temperature >"
            cell.statLabel.text = "100"
            cell.iconImageView.image = UIImage(named: "homeicon.png")
        case 2:
            cell.titleLabel.text = "Light State >"
            cell.statLabel.text = "BRIGHT"
            cell.iconImageView.image = UIImage(named: "tempicon.png")
        case 3:
            cell.titleLabel.text = "Suspicions Raised"
            cell.statLabel.text = "157"
            cell.iconImageView.image = UIImage(named: "emergencyicon.png")
        case 4:
            cell.titleLabel.text = "Humidity"
            cell.statLabel.text = "15%"
            cell.iconImageView.image = UIImage(named: "humidityicon.png")
        case 5:
            cell.titleLabel.text = "Motion Activity"
            cell.statLabel.text = "Quiet"
            cell.iconImageView.image = UIImage(named: "motionicon.png")
        default: return cell
        }
        
        cell.titleLabel.textColor = UIColor.tcReallyLightBlue
        cell.statLabel.textColor = UIColor.tcReallyLightBlue
        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func toggleDoorSettings(){
        if doorContainerBottomConstraint.constant == CGFloat(-200) {
            doorContainerBottomConstraint.constant = screenHeight/2 - 50
            tableView.isUserInteractionEnabled = false
        } else {
            doorContainerBottomConstraint.constant = -200
            tableView.isUserInteractionEnabled = true
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
    }
}
