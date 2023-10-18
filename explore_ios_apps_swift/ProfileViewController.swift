//
//  ProfileViewController.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 13/10/23.
//

import UIKit

private let profileCell = "ProfileCell"

class ProfileViewController: UIViewController{
    
    let dataProfile = Profile(name: "ADit", job: "Developer", age: 27, bio: "Halo Developer Mode")

    let profileTypeOrder = [
        ProfileType.name,
        ProfileType.job,
        ProfileType.age,
        ProfileType.bio
    ]
    
    @IBOutlet weak var tblViewProfile: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewProfile.register(
            UINib(
                nibName: "ProfileTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: profileCell
        )
        
//        tblViewProfile.dataSource = self
//        tblViewProfile.delegate = self
        
        tblViewProfile.rowHeight = UITableView.automaticDimension
        tblViewProfile.estimatedRowHeight = 216
        // Do any additional setup after loading the view.
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell, for: indexPath) as! ProfileTableViewCell
        
        let cellData: [(ProfileType, String)] = [
            (profileTypeOrder[0], dataProfile.name),
            (profileTypeOrder[1], dataProfile.job),
            (profileTypeOrder[2], String(dataProfile.age)),
            (profileTypeOrder[3], dataProfile.bio)
        ]
    
        cell.setValue(
            type: cellData[indexPath.row].0,
            value: cellData[indexPath.row].1
        )
        
        return cell
    }
}


