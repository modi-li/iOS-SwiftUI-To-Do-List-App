//
//  AddItemListView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct AddItemListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var itemListName = ""
    
    @State var showItemListWithNameExistsAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $itemListName)
                }
            }
            .navigationTitle("Add List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        do {
                            let existingItemListsWithNewName = try modelContext.fetch(FetchDescriptor<ItemList>(predicate: #Predicate{ $0.name == itemListName }))
                            if (existingItemListsWithNewName.isEmpty) {
                                if (itemListName.isEmpty) {
                                    addItemList(name: "List " + Helpers.defaultCurrentDateString)
                                } else {
                                    addItemList(name: itemListName)
                                }
                                dismiss()
                            } else {
                                showItemListWithNameExistsAlert = true
                            }
                        } catch {
                            
                        }
                    } label: {
                        Text("Add")
                            .fontWeight(.medium)
                    }
                }
            }
            .alert("List Already Exists", isPresented: $showItemListWithNameExistsAlert) {
                Button("Ok") {
                    showItemListWithNameExistsAlert = false
                }
            } message: {
                Text("Please try another name.")
            }
        }
    }
    
    func addItemList(name: String) {
        let itemList = ItemList(name: name)
        modelContext.insert(itemList)
    }
    
}

#Preview {
    AddItemListView()
}
