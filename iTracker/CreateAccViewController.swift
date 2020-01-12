//
//  SignUpViewController.swift
//  iTracker
//
//  Created by Vladimir on 16/11/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class CreateAccViewController: UIViewController {
    
    
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBAction func createPressed(_ sender: UIButton) {
        if textFields[0].text!.isEmpty == true || textFields[1].text!.isEmpty == true {
            let alert = UIAlertController(title: "Invalid Account Data", message: "Please fill in all the fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else if textFields[2].text != textFields[1].text {
            let alert = UIAlertController(title: "Passwords Must Match!", message: "Please enter matching passwords", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Congratulations!", message: "User \(String(textFields[0].text!)) has successfully registered", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Excellent!", style: .default, handler: { action -> Void in self.performSegue(withIdentifier: "unwindToLoginSegue", sender: nil) })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
