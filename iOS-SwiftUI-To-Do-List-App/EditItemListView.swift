//
//  EditItemListView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

struct EditItemListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var itemList: ItemList
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $itemList.name)
                }
            }
            .navigationTitle("Edit List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }
    
}
