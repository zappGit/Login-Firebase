//
//  ViewController.swift
//  lazyBartender
//
//  Created by Артем Хребтов on 02.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
    }
    
  
    
}

