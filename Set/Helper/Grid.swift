//
//  AspectVGrid.swift
//  Set
//
//  Created by Evgeniy Nik on 22.02.2022.
//

import SwiftUI

struct Grid <Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
     
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView ){
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
           self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout)-> some View {
        ForEach(items) {item in
           self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index =  items.firstIndex(where: {$0.id == item.id})!
        return viewForItem (item)
              .frame(width: layout.itemSize.width, height: layout.itemSize.height)
              .position (layout.location(ofItemAt: index))
    }
}

//mutating func choose(card: Card){
//    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id})! ,
//       !cards[chosenIndex].isSelected,
//       !cards[chosenIndex].isMatched {
