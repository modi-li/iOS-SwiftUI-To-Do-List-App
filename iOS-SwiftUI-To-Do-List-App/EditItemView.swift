//
//  EditItemView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct EditItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query private var itemLists: [ItemList]
    
    @Binding var item: Item
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $item.title)
                }
                Section {
                    List(itemLists) { itemList in
                        SelectionRowView(title: itemList.title, isSelected: item.itemLists.contains(itemList)) {
                            if item.itemLists.contains(itemList) {
                                item.itemLists.removeAll(where: { $0 == itemList })
                            } else {
                                item.itemLists.append(itemList)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
}

#Preview {
    @State var item = Item()
    return EditItemView(item: $item)
}
