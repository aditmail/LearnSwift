//
//  EmployeeTableViewCell.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 18/10/23.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvUmur: UILabel!
    @IBOutlet weak var tvGaji: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setValue(employee: Employee){
        tvGaji.text = String(employee.salary)
        tvName.text = employee.name
        tvUmur.text = String(employee.age)
    }
}
