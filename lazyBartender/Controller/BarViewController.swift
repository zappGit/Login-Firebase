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
    
    var cellText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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
    
   
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add task", message: "Please enter task", preferredStyle: .alert)
        alert.addTextField()
        let add = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let textField = alert.textFields?.first , textField.text != "" else {
                return
            }
           
        }
        //some code
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(add)
        alert.addAction(cancel)

        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func email(completion: @escaping(String) -> ()) {
        var userEmail = ""
        let db = Firestore.firestore()
//        let userId = db.collection("users").document()
//        print(userId)
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


