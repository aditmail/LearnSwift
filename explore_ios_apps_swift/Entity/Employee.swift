//
//  Employee.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 18/10/23.
//

import Foundation

struct Employee:Decodable{
    let name: String
    let age, salary: Int
    
    enum CodingKeys: String, CodingKey{
        case name = "employee_name"
        case age = "employee_age"
        case salary = "employee_salary"
    }
}

struct EmployeeDTO: Decodable{
    var status: String
    var data: [Employee]
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
    }
}
