//
//  ViewController.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 12/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    var strName:String = ""
    
    @IBAction func btnClick(_ sender: UIButton) {
        print("Test")
        
        strName = "Hello, Mail"
        performSegue(withIdentifier: "segueClick", sender: nil)
    }
    @IBOutlet weak var txtWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueClick" {
            let destination = segue.destination as! NewViewController
            
            destination.strParsedName = strName
        }
    }
}

