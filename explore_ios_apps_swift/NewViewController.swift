//
//  NewViewController.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 13/10/23.
//

import UIKit

class NewViewController: UIViewController {
    
    var strParsedName: String = ""
    
    @IBOutlet weak var txtHello: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tvDesc: UITextView!
    @IBAction func etVal(_ sender: UITextField) {
        print("Value")
    }
    
    @IBAction func btnClickMe(_ sender: UIButton) {
        print("Value")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtHello.text = strParsedName

        // Do any additional setup after loading the view.
    }
}
