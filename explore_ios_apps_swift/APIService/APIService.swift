//
//  APIService.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit
import Alamofire

class APIService: NSObject {
    func fetchEmployee(
        onSuccess: @escaping ([Employee]) -> Void,
        onError: @escaping (Error?) -> Void
    ){
        guard let urlAPI = URL(string: "https://dummy.restapiexample.com/api/v1/employees"
        ) else {return}
        
        let urlConvertible: URLConvertible = urlAPI
        
        AF.request(
            urlConvertible,
            method: .get
        ).response{
            response in
            if let responseData = response.data{
                do{
                    let data = try JSONDecoder().decode(EmployeeDTO.self, from: responseData)
                    
                    DispatchQueue.main.async {
                        onSuccess(data.data)
                    }
                }catch let jsonErr{
                    onError(jsonErr)
                }
            }
        }
    }
}
