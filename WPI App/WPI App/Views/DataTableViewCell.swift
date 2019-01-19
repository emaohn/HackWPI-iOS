//
//  DoorDataTableViewCell.swift
//  SmartHome
//
//  Created by Emmie Ohnuki on 1/18/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 15
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        iconImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        iconImageView.layer.shadowOpacity = 1
        iconImageView.layer.shadowOffset = CGSize.zero
        iconImageView.layer.shadowColor = UIColor.black.cgColor
        iconImageView.layer.shadowRadius = 15
        iconImageView.layer.cornerRadius = 10
        iconImageView.layer.masksToBounds = true
    }
}
