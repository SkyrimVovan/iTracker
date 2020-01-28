//
//  Task.swift
//  iTracker
//
//  Created by Vladimir on 25/12/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import Foundation
import UIKit

struct Task {
    var user: User?
    var name = String()
    var image = UIImage.init(systemName: "square.fill")!
    var color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var desc = String()
    var isActivated = false
    var time = 0
}
