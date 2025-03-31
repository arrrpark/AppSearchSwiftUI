//
//  Item.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
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
