//
//  DataSettingViewController.swift
//  WPI App
//
//  Created by Emmie Ohnuki on 1/19/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DoorSettingViewController: UIViewController {
    var locked = false
    @IBOutlet weak var doorLockedSwitch: UISwitch!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDoorData), name: NSNotification.Name("ReloadDoorData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLockStateTrue), name: NSNotification.Name("ChangeLockStateTrue"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLockStateFalse), name: NSNotification.Name("ChangeLockStateFalse"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLockTitle), name: NSNotification.Name("SetLockTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLightTitle), name: NSNotification.Name("SetLightTitle"), object: nil)
    }
    
    @IBAction func doorLockedToggled(_ sender: UISwitch) {
        guard let title = titleLabel.text else {return}
        if title == "LOCK DOOR" {
            ref?.child("devices/\(913)/lockstate").setValue(!locked)
        } else {
            ref?.child("devices/\(913)/lightstate").setValue(!locked)
        }
        locked = !locked
        reloadDoorData()
//        NotificationCenter.default.post(name: NSNotification.Name("ToggleDoorSettings"), object: nil)
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleDoorSettings"), object: nil)
    }
    
    @objc func reloadDoorData() {
        if locked {
            doorLockedSwitch.isOn = true
        } else {
            doorLockedSwitch.isOn = false
        }
    }
    
    @objc func changeLockStateTrue() {
        locked = true
    }
    
    @objc func changeLockStateFalse() {
        locked = false
    }
    
    @objc func setLockTitle(){
        titleLabel.text = "LOCK DOOR"
    }
    
    @objc func setLightTitle() {
        titleLabel.text = "LIGHTS ON"
    }
}
