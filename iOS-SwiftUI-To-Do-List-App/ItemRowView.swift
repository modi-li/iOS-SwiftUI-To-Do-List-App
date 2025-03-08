//
//  ItemRowView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

struct ItemRowView: View {
    
    var item: Item
    
    var rowTapAction: () -> ()
    
    var body: some View {
        HStack {
            Button {
                item.isFinished.toggle()
            } label: {
                Image(systemName: item.isFinished ? "square.fill" : "square")
                    .font(.system(size: 18))
                    .foregroundStyle(item.isFinished ? Color(UIColor.systemGray5) : .secondary)
            }
            .buttonStyle(.borderless)
            
            Text(item.name)
                .font(.system(size: 18))
                .foregroundStyle(item.isFinished ? .secondary : .primary)
            Spacer()
            Text(item.displayItemListNames)
                .foregroundStyle(item.isFinished ? Color(UIColor.systemGray3) : .secondary)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            rowTapAction()
        }
    }
    
}
