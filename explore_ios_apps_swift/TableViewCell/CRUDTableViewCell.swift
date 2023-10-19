//
//  CRUDTableViewCell.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit

class CRUDTableViewCell: UITableViewCell {

    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvSalary: UILabel!
    @IBOutlet weak var tvID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(crud: CRUD){
        tvName.text = crud.name
        tvID.text = crud.id
        tvSalary.text = crud.salary
    }
}
