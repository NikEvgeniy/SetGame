//
//  SetCardGame.swift
//  Set
//
//  Created by Evgeniy Nik on 14.03.2022.
//

import SwiftUI

enum FillInSet: Int, CaseIterable {
    case stroke = 1
    case fill
    case stripe
    case blur
}
enum ShapesInSet: Int, CaseIterable {
    case diamond = 1
    case oval
    case squiggle
    case rainDrop
}

struct Setting {
    var colorsShapes = [Color.green,Color.red,Color.purple ]
    var colorsBorder: [Color] = [#colorLiteral(red: 0.1940105259, green: 0.003823338309, blue: 0.9934375882, alpha: 1),#colorLiteral(red: 0.9955675006, green: 0.001091319602, blue: 0.1432448924, alpha: 1),#colorLiteral(red: 0.9914981723, green: 0.9005147815, blue: 0.01922592521, alpha: 1) ].map {Color($0)}
    var colorHint: Color = Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1))
    
    // possible: .stroke, .fill, .stripe, blur
    var fillShapes = [FillInSet.stroke, .stripe, .fill]
    
    // possible: .diamond, .oval, .squiggle, rainDrop
    var shapes = [ShapesInSet.diamond, .oval, .squiggle]
}

class SetCardGame: ObservableObject{
    @Published private var model: SetGame<SetCard> = SetCardGame.createSetGame()
    
    static func createSetGame() -> SetGame<SetCard>{
        SetGame<SetCard> (numberOfCardsStart: numberOfCardsStart,
                          numberOfCardsInDeck: deck.cards.count) {index in
            deck.cards[index]
        }
    }
    static var numberOfCardsStart = 12
    static private var deck = SetCardDeck()
    
    // Mark: - Access to the Model
    
    var cards: Array<SetGame<SetCard>.Card> {
        model.cards
    }
    //Mark: - Intent(s)
    func choose(card: SetGame<SetCard>.Card){
        model.choose(card: card)
    }
    
    func deal(){
        model.deal()
    }
}


