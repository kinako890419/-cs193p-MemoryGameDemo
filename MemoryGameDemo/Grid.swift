//
//  Grid.swift
//  MemoryGameDemo
//
//  Created by 兔子 on 2021/6/29.
//

import SwiftUI

struct Grid<Item,itemView>: View where Item: Identifiable, itemView: View {
    
    private var items: [Item]
    private var viewForItem: (Item) -> itemView
    init(_ items:[Item], viewForItem: @escaping (Item) -> itemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader{ geometry in
            body(for: GridLayout(itemCount:  items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items){ item in
            body(for: item, in: layout)
            //viewForItem(item)
        }
    }
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index =  items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
}

