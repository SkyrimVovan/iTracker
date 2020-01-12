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
    var name: String
    var image: UIImage
    var color: UIColor
    var description: String
    var isActivated: Bool
    var time: Int
}
