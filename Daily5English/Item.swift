//
//  Item.swift
//  Daily5English
//
//  Created by 김민성 on 12/16/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
