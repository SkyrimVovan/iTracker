//
//  TaskTableViewCell.swift
//  iTracker
//
//  Created by Vladimir on 25/12/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var taskActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    var mainVC: MainViewController?
    
}
