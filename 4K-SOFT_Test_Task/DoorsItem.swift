//
//  DoorsItem.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 08.09.2022.
//

import UIKit

enum LockedState: Int, Codable {
    case close = 0
    case open
    case loading
}

class DoorsItem: Codable {
    
    var isLocked: LockedState = .close
    var doorsPlacement: String!
    var doorsImage: String!
    var doorsName: String!
}


