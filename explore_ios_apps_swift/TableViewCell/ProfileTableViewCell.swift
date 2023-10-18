//
//  ProfileTableViewCell.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 13/10/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(type: ProfileType, value: String){
        tvTitle.text = type.rawValue
        tvDescription.text = value
        
        print("Label: " + type.rawValue)
        print("Values: " + value)
        
        if type == ProfileType.bio {
            tvDescription.numberOfLines = 0
        }else{
            tvDescription.numberOfLines = 1
        }
    }
    
}
