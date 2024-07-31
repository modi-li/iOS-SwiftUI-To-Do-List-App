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
    var title: String = ""
    var isFinished: Bool = false
    @Relationship(inverse: \ItemList.items) var itemLists: [ItemList] = []
    
    init(title: String = "") {
        self.title = title
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
}


@Model
final class ItemList {
    
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var title: String = ""
    var items: [Item] = []
    
    init(title: String = "") {
        self.title = title
    }
    
}
