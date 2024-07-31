//
//  AllItemListsView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct AllItemListsView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var itemLists: [ItemList]
    
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(itemLists) { itemList in
                    NavigationLink {
                        ItemListView(itemList: itemList)
                    } label: {
                        Text(itemList.title)
                    }
                }
                .onDelete(perform: deleteItemLists)
            }
            .navigationTitle("All Lists")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Text("Add List")
                    }
                }
            }
            .overlay {
                if itemLists.isEmpty {
                    ContentUnavailableView {
                        Label("No Lists", systemImage: "list.bullet.below.rectangle")
                    } description: {
                        Text("Start by adding a list.")
                    } actions: {
                        Button("Add List") {
                            sheetIsPresented = true
                        }
                    }
                    .offset(y: -50)
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            AddItemListView()
        }
    }
    
    private func deleteItemLists(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(itemLists[index])
            }
        }
    }
    
}

#Preview {
    AllItemListsView()
}
