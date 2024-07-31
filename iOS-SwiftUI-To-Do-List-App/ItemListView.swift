//
//  ItemListView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct ItemListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var itemList: ItemList = ItemList()
    
    @State private var editItemListSheetIsPresented = false
    
    @State private var editItemSheetIsPresented = false
    
    @State private var addItemSheetIsPresented = false
    
    @State private var selectedItemToEdit = Item()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(itemList.items.sorted {
                    if $0.isFinished == $1.isFinished {
                        return $0.timestamp > $1.timestamp
                    } else {
                        return $0.isFinished < $1.isFinished
                    }
                }) { item in
                    ItemRowView(item: item) {
                        selectedItemToEdit = item
                        editItemSheetIsPresented.toggle()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle(itemList.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            addItemSheetIsPresented.toggle()
                        } label: {
                            Text("Add Item")
                        }
                        Button {
                            editItemListSheetIsPresented.toggle()
                        } label: {
                            Text("Edit List")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .overlay {
                if itemList.items.isEmpty {
                    ContentUnavailableView {
                        Label("No Items", systemImage: "list.bullet.rectangle.portrait")
                    } description: {
                        Text("Start by adding an item.")
                    } actions: {
                        Button("Add Item") {
                            addItemSheetIsPresented = true
                        }
                    }
                    .offset(y: -50)
                }
            }
            .sheet(isPresented: $editItemListSheetIsPresented) {
                EditItemListView(itemList: $itemList)
            }
            .sheet(isPresented: $editItemSheetIsPresented) {
                EditItemView(item: $selectedItemToEdit)
            }
            .sheet(isPresented: $addItemSheetIsPresented) {
                AddItemView(selectedItemLists: [itemList])
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(itemList.items[index])
            }
        }
    }
    
}

#Preview {
    ItemListView()
}
