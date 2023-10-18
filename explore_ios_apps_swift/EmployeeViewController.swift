//
//  EmployeeViewController.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 18/10/23.
//

import UIKit
import Alamofire
import SwiftUI

private let employeeCell = "EmployeeCell"

struct EmployeeDTO: Decodable{
    var status: String
    var data: [Employee]
    
//    init(status: String, data: [Employee]){
//        self.status = status
//        self.data = data
//    }
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
    }
}

class EmployeeViewController: UIViewController {
    
    @IBOutlet weak var tblEmployee: UITableView!
    var arrEmployee: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblEmployee.register(
            UINib(
                nibName: "EmployeeTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: employeeCell
        )
        
        tblEmployee.dataSource = self
        tblEmployee.delegate = self
        
        tblEmployee.rowHeight = UITableView.automaticDimension
        tblEmployee.estimatedRowHeight = 400
        
        guard let urlAPI = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {return}
        
        let urlConvertible: URLConvertible = urlAPI
        
        AF.request(
            urlConvertible,
            method: .get,
            parameters: nil,
            headers: nil
        ).response{
            responseData in
            guard let respData = responseData.data else { return }
            do{
                print(responseData, respData)
                let response = try JSONDecoder().decode(
                    EmployeeDTO.self, from: respData)
                
                //onSuccess(response)
                self.arrEmployee.append(contentsOf: response.data)
                self.tblEmployee.reloadData()
            }catch let jsonErr{
                debugPrint("ErrJSON: ", jsonErr)
            }
        }
    }
}



extension EmployeeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrEmployee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: employeeCell, for: indexPath) as! EmployeeTableViewCell
        cell.setValue(employee: self.arrEmployee[indexPath.row])
        return cell
    }
}
