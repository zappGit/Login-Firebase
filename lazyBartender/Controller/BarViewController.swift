//
//  BarViewController.swift
//  lazyBartender
//
//  Created by Артем Хребтов on 02.08.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class BarViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        email(completion: { text in
            cell.textLabel?.text = "Hello user with email: \(text)"
        })
        cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.7466557622, green: 0.07221702486, blue: 0.1043173745, alpha: 0.5)
        tableView.backgroundColor = #colorLiteral(red: 0.7466557622, green: 0.07221702486, blue: 0.1043173745, alpha: 0.5)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    // Work with firebase. Read email and safe it.
    //Use complition cos firebase reading is async
    func email(completion: @escaping(String) -> ()) {
        var userEmail = ""
        let db = Firestore.firestore()
        let id = (Auth.auth().currentUser?.uid)!
        let docRef = db.collection("users").document(id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userEmail = document.data()?["email"] as! String
                completion(userEmail)
            }
        }
    }
}


