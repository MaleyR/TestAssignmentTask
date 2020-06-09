//
//  Message.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 06.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

struct Message: Identifiable, Hashable, Decodable {
    var id: Int
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
    }
}
