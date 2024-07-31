//
//  ItemRowView.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

struct ItemRowView: View {
    
    var item: Item
    
    var rowTapAction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                item.isFinished.toggle()
            } label: {
                Image(systemName: item.isFinished ? "circle.fill" : "circle")
                    .foregroundStyle(item.isFinished ? .gray : .blue)
            }
            .buttonStyle(.borderless)
            
            Text(item.title)
                .foregroundStyle(item.isFinished ? .secondary : .primary)
            Spacer()
        }
        .onTapGesture {
            rowTapAction()
        }
    }
    
}
