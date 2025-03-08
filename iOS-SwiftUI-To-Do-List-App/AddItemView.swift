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
    
    @Query private var items: [Item]
    
    @Query private var itemLists: [ItemList]
    
    @State private var itemName = ""
    
    @State var selectedItemLists: [ItemList] = []
    
    @State var showItemWithNameExistsAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $itemName)
                }
                Section("Lists") {
                    List(itemLists) { itemList in
                        SelectionRowView(name: itemList.name, isSelected: selectedItemLists.contains(itemList)) {
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
                        do {
                            let existingItemsWithNewName = try modelContext.fetch(FetchDescriptor<Item>(predicate: #Predicate{ $0.name == itemName }))
                            if (existingItemsWithNewName.isEmpty) {
                                if (itemName.isEmpty) {
                                    addItem(name: "Item " + Helpers.defaultCurrentDateString, selectedItemLists: selectedItemLists)
                                } else {
                                    addItem(name: itemName, selectedItemLists: selectedItemLists)
                                }
                                dismiss()
                            } else {
                                showItemWithNameExistsAlert = true
                            }
                        } catch {
                            
                        }
                    } label: {
                        Text("Add")
                            .fontWeight(.medium)
                    }
                }
            }
            .alert("Item Already Exists", isPresented: $showItemWithNameExistsAlert) {
                Button("Ok") {
                    showItemWithNameExistsAlert = false
                }
            } message: {
                Text("Please try another name.")
            }
        }
    }
    
    func addItem(name: String, selectedItemLists: [ItemList]) {
        let item = Item(name: name)
        modelContext.insert(item)
        item.itemLists = selectedItemLists
        try? modelContext.save()
    }
    
}

#Preview {
    AddItemView()
}
