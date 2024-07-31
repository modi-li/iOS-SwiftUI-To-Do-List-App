//
//  AddItemView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var itemLists: [ItemList]
    
    @State private var itemTitle = ""
    
    @State var selectedItemLists: [ItemList] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $itemTitle)
                }
                Section {
                    List(itemLists) { itemList in
                        SelectionRowView(title: itemList.title, isSelected: selectedItemLists.contains(itemList)) {
                            if selectedItemLists.contains(itemList) {
                                selectedItemLists.removeAll(where: { $0 == itemList })
                            } else {
                                selectedItemLists.append(itemList)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addItem(title: itemTitle, selectedItemLists: selectedItemLists)
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
    
    func addItem(title: String, selectedItemLists: [ItemList]) {
        let item = Item(title: title)
        modelContext.insert(item)
        item.itemLists = selectedItemLists
        try? modelContext.save()
    }
    
}

#Preview {
    AddItemView()
}
