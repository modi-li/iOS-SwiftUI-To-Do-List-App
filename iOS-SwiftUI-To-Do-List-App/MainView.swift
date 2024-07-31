//
//  MainView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @Query private var itemLists: [ItemList]
    
    @State private var visibility: NavigationSplitViewVisibility = .doubleColumn
    
    @State private var addItemListSheetIsPresented = false
    
    var body: some View {
        if horizontalSizeClass == .compact {
            TabView {
                AllItemsView()
                    .tabItem {
                        Label("All Items", systemImage: "list.bullet.rectangle.portrait")
                    }
                AllItemListsView()
                    .tabItem {
                        Label("All Lists", systemImage: "list.bullet.below.rectangle")
                    }
            }
        } else {
            NavigationSplitView(columnVisibility: $visibility) {
                List {
                    NavigationLink {
                        AllItemsView()
                    } label: {
                        Label("All Items", systemImage: "list.bullet.rectangle.portrait")
                    }
                    DisclosureGroup {
                        ForEach(itemLists) { itemList in
                            NavigationLink {
                                ItemListView(itemList: itemList)
                            } label: {
                                Label(itemList.title, systemImage: "list.bullet.below.rectangle")
                            }
                        }
                        .onDelete(perform: deleteItemLists)
                    } label: {
                        NavigationLink {
                            AllItemListsView()
                        } label: {
                            Text("All Lists (\(itemLists.count))")
                        }
                    }
                }
                .navigationTitle("To-Do List")
                .navigationBarTitleDisplayMode(.large)
                HStack {
                    Spacer()
                    Button {
                        addItemListSheetIsPresented.toggle()
                    } label: {
                        Text("Add List")
                    }
                }
                .padding(.top, 10)
                .padding(.trailing, 20)
                .padding(.bottom, 15)
            } detail: {
                AllItemsView()
            }
            .navigationSplitViewStyle(.balanced)
            .sheet(isPresented: $addItemListSheetIsPresented) {
                AddItemListView()
            }
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
    MainView()
}
