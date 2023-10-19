//
//  EmployeeViewModel.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit

class EmployeeViewModel: NSObject {
    private var apiService: APIService
    
    private (set) var employeeData: [Employee] = []{
        didSet{
            self.bindDataToVC()
        }
    }
    
    var bindDataToVC: () -> () = {}
    
    override init() {
        apiService = APIService()
        super.init()
    }
    
    func fetchData(){
        apiService.fetchEmployee{
            employees in self.employeeData = employees}
            onError: {
                error in print(error ?? "")
            }
    }
}
