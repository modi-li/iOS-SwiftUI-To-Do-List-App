//
//  AddItemListView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

struct AddItemListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var itemListTitle = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $itemListTitle)
                }
            }
            .navigationTitle("Add List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addItemList(title: itemListTitle)
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
    
    func addItemList(title: String) {
        let itemList = ItemList(title: title)
        modelContext.insert(itemList)
    }
    
}

#Preview {
    AddItemListView()
}
