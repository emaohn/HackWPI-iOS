//
//  HomeViewController.swift
//  SmartHome
//
//  Created by Emmie Ohnuki on 1/18/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        //case 0: self.performSegue(withIdentifier: "openDoorActivity", sender: self)
        case 1: self.performSegue(withIdentifier: "openTempActivity", sender: self)
        case 2: self.performSegue(withIdentifier: "openLightActivity", sender: self)
        case 3: self.performSegue(withIdentifier: "openHomeActivity", sender: self)
        default: print("nothing")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Door State"
            cell.titleLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.text = "LOCKED"
            cell.selectionStyle = .none
            cell.iconImageView.image = UIImage(named: "lockicon.png")
            return cell
        case 1:
            cell.titleLabel.text = "Temperature"
            cell.titleLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.text = "100"
            cell.selectionStyle = .none
            cell.iconImageView.image = UIImage(named: "homeicon.png")
            return cell
        case 2:
            cell.titleLabel.text = "Light Activity"
            cell.statLabel.text = "BRIGHT"
            cell.titleLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.textColor = UIColor.tcReallyLightBlue
            cell.selectionStyle = .none
            cell.iconImageView.image = UIImage(named: "tempicon.png")
            return cell
        case 3:
            cell.titleLabel.text = "Suspicions Raised"
            cell.titleLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.text = "Quiet"
            cell.selectionStyle = .none
            cell.iconImageView.image = UIImage(named: "emergencyicon.png")
            return cell
        case 4:
            cell.titleLabel.text = "Humidity"
            cell.titleLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.text = "15%"
            cell.selectionStyle = .none
            cell.iconImageView.image = UIImage(named: "emergencyicon.png")
            return cell
        case 5:
            cell.titleLabel.text = "Motion Activity"
            cell.titleLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.textColor = UIColor.tcReallyLightBlue
            cell.statLabel.text = "Quiet"
            cell.selectionStyle = .none
            cell.iconImageView.image = UIImage(named: "emergencyicon.png")
            return cell
        default: return UITableViewCell()
        }
    }

    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
    }
}
