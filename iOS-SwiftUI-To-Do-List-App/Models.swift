//
//  Item.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import Foundation
import SwiftData

@Model
final class Item: Equatable {
    
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var name: String = ""
    var isFinished: Bool = false
    @Relationship(inverse: \ItemList.items) var itemLists: [ItemList] = []
    
    init(name: String = "") {
        self.name = name
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    var displayItemListNames: String {
        var result = ""
        for name in itemLists.map({ $0.name }) {
            if result.count + name.count + (result.isEmpty ? 0 : 2) <= 16 {
                if !result.isEmpty {
                    result += ", "
                }
                result += name
            } else {
                result = "\(itemLists.count) Lists"
                break
            }
        }
        return result
    }
    
}


@Model
final class ItemList {
    
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var name: String = ""
    var items: [Item] = []
    
    init(name: String = "") {
        self.name = name
    }
    
}
