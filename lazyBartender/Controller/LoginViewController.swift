//
//  ViewController.swift
//  lazyBartender
//
//  Created by Артем Хребтов on 02.08.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var pass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        pass.layer.cornerRadius = pass.frame.size.height/2
        self.hideKeyboardWhenTappedAround()
        //Check auth of current user if its true show next vc
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
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
    //Log in check
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = loginTextField.text,
              let password = passwordTextfield.text,
              email != "",
              password != "" else {
            return
        }
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
    //Registration
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = loginTextField.text,
              let password = passwordTextfield.text,
              email != "",
              password != "" else { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard error == nil, user != nil else {
                print (error?.localizedDescription as Any)
                return
            }
            let db = Firestore.firestore()
            let userId: String = (Auth.auth().currentUser?.uid)!
            let newUser = db.collection("users").document("\(userId)")
            newUser.setData(["email": (self?.loginTextField.text)!, "password": (self?.passwordTextfield.text)!, "id": userId])
        }
    }
    //Forgot pass
    @IBAction func test(_ sender: Any) {
        guard let email = loginTextField.text,
              email != ""  else {return}
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print("error")
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
