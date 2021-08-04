//
//  ViewController.swift
//  lazyBartender
//
//  Created by Артем Хребтов on 02.08.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        self.hideKeyboardWhenTappedAround()
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTextField.text = ""
        passwordTextfield.text = ""
        
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = loginTextField.text,
              let password = passwordTextfield.text,
              email != "",
              password != "" else {
            return
        }
        //Проверка на логин
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                print("\(String(describing: error))")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
                return
            }
                
        }
        
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = loginTextField.text,
              let password = passwordTextfield.text,
              email != "",
              password != "" else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if user != nil {
                    
                } else {
                    print ("user is not created")
                }
            }
        }
    }
    
    @IBAction func test(_ sender: Any) {
        guard let email = loginTextField.text,
              email != ""  else {return}
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print("\(error)")
            }
        }
    }
    
        

    }
    
  
    


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
