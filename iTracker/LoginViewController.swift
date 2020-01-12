//
//  ViewController.swift
//  ATracker
//
//  Created by Vladimir on 15/12/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var users = [User]()
    var userNum = Int()
    @IBOutlet var textFields: [UITextField]!
    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToLoginSegue" else { return }
        guard let svcCA = segue.source as? CreateAccViewController else { return }
        users.append(User(name: svcCA.textFields[0].text!, password: svcCA.textFields[1].text!))
    }
    @IBAction func signupPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateAccSegue", sender: nil)
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        if textFields[0].text!.isEmpty == true || textFields[1].text!.isEmpty == true {
            let alert = UIAlertController(title: "Invalid account data", message: "Please enter valid account data", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else if users.isEmpty == true {
            let alert = UIAlertController(title: "Invalid account data", message: "There are no such users", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            for user in users {
                if (user.name,user.password) == (textFields[0].text,textFields[1].text) {
                    performSegue(withIdentifier: "toMainSegue", sender: user)
                } else if (users[users.count-1].name,users[users.count-1].password) == (user.name,user.password){
                    let alert = UIAlertController(title: "Invalid account data", message: "There are no such users", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainSegue" {
            guard let dvcM = segue.destination as? MainViewController else { return }
            dvcM.user = (sender as! User)
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}

