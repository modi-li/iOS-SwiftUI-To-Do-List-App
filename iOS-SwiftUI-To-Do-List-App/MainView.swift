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
    
    @State private var allItemListsExpanded = true
    
    @State private var addItemListSheetIsPresented = false
    
    var body: some View {
        if horizontalSizeClass == .compact {
            TabView {
                AllItemsView()
                    .tabItem {
                        Label("Items", systemImage: "checkmark.square")
                    }
                AllItemListsView()
                    .tabItem {
                        Label("Lists", systemImage: "rectangle.stack")
                    }
            }
        } else {
            NavigationSplitView(columnVisibility: $visibility) {
                List {
                    NavigationLink {
                        AllItemsView()
                    } label: {
                        Label {
                            Text("All Items")
                                .font(.system(size: 20, weight: .medium))
                        } icon: {
                            Image(systemName: "checkmark.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22)
                                .fontWeight(.medium)
                        }
                    }
                    DisclosureGroup(isExpanded: $allItemListsExpanded) {
                        ForEach(itemLists) { itemList in
                            NavigationLink {
                                ItemListView(itemList: itemList)
                            } label: {
                                Text(itemList.name)
                            }
                        }
                        .onDelete(perform: deleteItemLists)
                    } label: {
                        NavigationLink {
                            AllItemListsView()
                        } label: {
                            Label {
                                Text("All Lists (\(itemLists.count))")
                                    .font(.system(size: 20, weight: .medium))
                            } icon: {
                                Image(systemName: "rectangle.stack")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26)
                                    .fontWeight(.medium)
                            }
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
                            .fontWeight(.medium)
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
