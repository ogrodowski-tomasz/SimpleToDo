//
//  ToDoItem.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import Foundation

/// Protocols:
/// - Identifiable: so we can show arrays of items in SwiftUI
/// - Codable: so we can load and save items
/// - Hashable: so we can store selected sets of items,
/// - CaseIterable:  so we can loop over each case in the Priority enum.
struct ToDoItem: Identifiable, Codable, Hashable {
    enum Priority: String, Codable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }

    var id = UUID()
    var title = "New Item"
    var priority = Priority.medium
    var isComplete = false

    var icon: String {
        if isComplete {
            return "checkmark.square"
        } else {
            switch priority {
            case .low:
                return "arrow.down.square"
            case .medium:
                return "square"
            case .high:
                return "exclamationmark.square"
            }
        }
    }

    static let example = ToDoItem()
}
