//
//  CRUDViewController.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit
import SwiftUI
import CoreData

private let crudCell = "CRUDCell"

class CRUDViewController: UIViewController {
    
    @IBOutlet weak var tblCRUD: UITableView!
    var arrEmployee: [CRUD] = []
    var viewModel: CRUDVIewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblCRUD.register(
            UINib(
                nibName: "CRUDTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: crudCell
        )
                
        viewModel = CRUDVIewModel()
        arrEmployee = viewModel.fetchData()
        
        viewModel.bindDataToVC = {
            self.tblCRUD.reloadData()
        }
        
        //viewModel.fetchData()
        
        tblCRUD.dataSource = self
        tblCRUD.delegate = self

        tblCRUD.rowHeight = UITableView.automaticDimension
        tblCRUD.estimatedRowHeight = 400
        
        debugPrint("ARR:", self.viewModel.crudData)
    }
    
    @IBAction func btn(_ sender: Any) {
        let alert = UIAlertController(
            title: "New Employee",
            message: "Fill the Form Below to Add New Employee",
            preferredStyle: .alert
        )
        
        alert.addTextField(configurationHandler: {
            tf in tf.placeholder = "ID"
        })
        
        alert.addTextField(configurationHandler: {
            tf in tf.placeholder = "Name"
        })
        
        alert.addTextField(configurationHandler: {
            tf in tf.placeholder = "Salary"
        })
        
        alert.addAction(UIAlertAction(
            title: "Tambah",
            style: .default,
            handler: {
                action in
                
                if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty{
                    
                    let warning = UIAlertController(
                        title: "Warning",
                        message: "Fill All the Textfields ",
                        preferredStyle: .alert
                    )
                    warning.addAction(UIAlertAction(
                        title: "Dismiss",
                        style: .default,
                        handler: nil)
                    )
                    self.present(warning, animated: true)
                    self.tblCRUD.reloadData()
                }else{
                    self.viewModel.create(alert.textFields![0].text ?? "<undefined>", alert.textFields![1].text!, alert.textFields![2].text!)
                    
                    let success = UIAlertController(
                        title: "Success",
                        message: "Data Employee Added",
                        preferredStyle: .alert
                    )
                    
                    success.addAction(UIAlertAction(
                        title: "Dismiss",
                        style: .default,
                        handler: nil))
                    
                    self.present(success, animated: true)
                    self.tblCRUD.reloadData()
                }
            })
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func editEmployee(_ id: String, _ name: String, _ salary:String, _ rowID: Int){
        let alert = UIAlertController(title: "Edit Employee", message: "Fill the Form below to Edit Employee", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {tf in
            tf.isEnabled = false
            tf.placeholder = "id"
            tf.text = "\(id)"
        })
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Name"
            tf.text = name
        })
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Salary"
            tf.text = salary
        })
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: {
            action in
            
            self.viewModel.update(id, alert.textFields![1].text!, alert.textFields![2].text!, rowID)
            
            let success = UIAlertController(title: "Success", message: "Data Employee Updated", preferredStyle: .alert)
            success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.present(success, animated: true)
            self.tblCRUD.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CRUDViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrEmployee.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: crudCell, for: indexPath) as! CRUDTableViewCell

        cell.setValue(crud: self.arrEmployee[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editEmployee(arrEmployee[indexPath.row].id, arrEmployee[indexPath.row].name, arrEmployee[indexPath.row].salary, indexPath.row)
        self.tblCRUD.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.viewModel.delete(arrEmployee[indexPath.row].id, indexPath.row)
            self.tblCRUD.reloadData()
        }
    }
}

