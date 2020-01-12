//
//  SignUpViewController.swift
//  iTracker
//
//  Created by Vladimir on 16/11/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class CreateAccViewController: UIViewController {

    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var passwordsMatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successLabel.isHidden = true
        passwordsMatchLabel.isHidden = true
        
    }
    

}
