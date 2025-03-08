//
//  AllItemsView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct AllItemsView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [
        SortDescriptor(\Item.isFinished),
        SortDescriptor(\Item.timestamp, order: .reverse)
    ]) private var items: [Item]
    
    @State private var addItemSheetIsPresented = false
    
    @State private var editItemSheetIsPresented = false
    
    @State private var selectedItemToEdit = Item()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ItemRowView(item: item) {
                        selectedItemToEdit = item
                        editItemSheetIsPresented.toggle()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("All Items")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addItemSheetIsPresented.toggle()
                    } label: {
                        Text("Add")
                            .fontWeight(.medium)
                    }
                }
            }
            .sheet(isPresented: $addItemSheetIsPresented) {
                AddItemView()
            }
            .sheet(isPresented: $editItemSheetIsPresented) {
                EditItemView(item: $selectedItemToEdit)
            }
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView {
                        Label("No Items", systemImage: "checkmark.square")
                    } actions: {
                        Button {
                            addItemSheetIsPresented = true
                        } label: {
                            Text("Add Item")
                                .font(.system(size: 16, weight: .medium))
                                .padding(.top, 12)
                        }
                    }
                    .offset(y: -50)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
}

#Preview {
    AllItemsView()
}
