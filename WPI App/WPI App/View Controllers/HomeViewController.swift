//
//  HomeViewController.swift
//  SmartHome
//
//  Created by Emmie Ohnuki on 1/18/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    var deviceData = [DataSnapshot]()
    var dataRetrieved = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doorSettingContainerView: UIView!
    @IBOutlet weak var doorContainerBottomConstraint: NSLayoutConstraint!
    
    var refreshControl = UIRefreshControl()
 
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        ref = Database.database().reference()
        
        retrieveData()
        setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDoorSettings), name: NSNotification.Name("ToggleDoorSettings"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleLock), name: NSNotification.Name("ToggleLock"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleLights), name: NSNotification.Name("ToggleLights"), object: nil)
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        retrieveData()
        refreshControl.endRefreshing()
    }
    
    func retrieveData() {
        let dataRef = Database.database().reference().child("devices")
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        DispatchQueue.main.async {
            dataRef.observeSingleEvent(of: .value) { (snapshot) in
                
                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return }
                
                self.deviceData = [DataSnapshot]()
                
                for device in snapshot {
                    self.deviceData.append(device)
                }
                self.dataRetrieved = true
                dispatchGroup.leave()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
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
        if dataRetrieved {
            return 6
        } else  {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name("SetLockTitle"), object: nil)
            let stat = deviceData[0].value as! [String: Any]
            let lockState = stat["lockstate"] as! Bool
            if lockState {
                NotificationCenter.default.post(name: NSNotification.Name("ChangeLockStateTrue"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("ChangeLockStateFalse"), object: nil)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("ReloadDoorData"), object: nil)
            toggleDoorSettings()
        case 1: self.performSegue(withIdentifier: "openTempActivity", sender: self)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("SetLightTitle"), object: nil)
            let stat = deviceData[0].value as! [String: Any]
            let lightstate = stat["lightstate"] as! Bool
            if lightstate {
                NotificationCenter.default.post(name: NSNotification.Name("ChangeLockStateTrue"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("ChangeLockStateFalse"), object: nil)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("ReloadDoorData"), object: nil)
            toggleDoorSettings()
        //case 3: self.performSegue(withIdentifier: "openHomeActivity", sender: self)
        default: print("nothing")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
        let stat = deviceData[0].value as! [String: Any]
        
        switch indexPath.row {
        case 0:
            let doorState = stat["doorstate"] as! Bool
            
            cell.titleLabel.text = "Door State >"
            if doorState {
                cell.statLabel.text = "OPEN"
            } else {
                cell.statLabel.text = "CLOSED"
            }
            cell.iconImageView.image = UIImage(named: "lockicon.png")
        case 1:
            let temp = stat["temperature"] as! Double
            cell.titleLabel.text = "Temperature >"
            cell.statLabel.text = "\(temp)"
            cell.iconImageView.image = UIImage(named: "homeicon.png")
        case 2:
            let lightState = stat["lightstate"] as! Bool
            cell.titleLabel.text = "Light State >"
            if lightState {
                cell.statLabel.text = "ON"
            } else {
                cell.statLabel.text = "OFF"
            }
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
        retrieveData()
    }
    
    @objc func toggleLights() {
        let stat = deviceData[0].value as! [String: Any]
        let lightState = stat["lightstate"] as! Bool
        ref.child("devices/\(913)/lightstate").setValue(!lightState)
    }
    
    @objc func toggleLock() {
        let stat = deviceData[0].value as! [String: Any]
        let lockState = stat["lockstate"] as! Bool
        ref.child("devices/\(913)/lockstate").setValue(!lockState)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "openTempActivity":
            guard let destination = segue.destination as? TempActivityViewController else {return}
            destination.stats = (deviceData[0].value as! [String: Any])
        default: return
        }
    }
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        retrieveData()
    }

}
