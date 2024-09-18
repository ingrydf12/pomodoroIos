//
//  Item.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 18/09/24.
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
