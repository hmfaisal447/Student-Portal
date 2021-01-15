//
//  ViewController.swift
//  Student Portal
//
//  Created by codegradients on 29/12/2020.
//

import UIKit

class StudentSignInVC: UIViewController {

    
    @IBOutlet weak var txtStdCNIC: UITextField!
    @IBOutlet weak var txtStdPassword: UITextField!
    @IBOutlet weak var stdSignInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stdSignInBtn.layer.cornerRadius = 10
    }
    
    @IBAction func stdSignBtn(_ sender: UIButton) {
        let stdCNIC = txtStdCNIC.text
        let stdPassword = txtStdPassword.text
        if stdCNIC ==
    }
}

