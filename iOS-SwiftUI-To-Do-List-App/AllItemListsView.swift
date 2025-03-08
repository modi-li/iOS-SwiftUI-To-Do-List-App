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
                        HStack {
                            Text(itemList.name)
                                .font(.system(size: 18))
                            Spacer()
                            Text("\(itemList.items.count)")
                                .foregroundStyle(Color.secondary)
                        }
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
                        Text("Add")
                            .fontWeight(.medium)
                    }
                }
            }
            .overlay {
                if itemLists.isEmpty {
                    ContentUnavailableView {
                        Label("No Lists", systemImage: "rectangle.stack")
                    } actions: {
                        Button {
                            sheetIsPresented = true
                        } label: {
                            Text("Add List")
                                .font(.system(size: 16, weight: .medium))
                                .padding(.top, 12)
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
