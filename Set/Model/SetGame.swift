//
//  SetGame.swift
//  Set
//
//  Created by Evgeniy Nik on 22.02.2022.
//

import Foundation

protocol Matchable {
    static func match (cards: [Self]) -> Bool
}

struct SetGame <CardContent> where CardContent: Matchable {
    private (set) var cards = [Card]()
    private (set) var deck = [Card]()
    
    let numberOfCardsToMatch = 3
    var numberOfCardsStart = 12
    
    private var selectedIndices: [Int] {cards.indices.filter {cards[$0].isSelected}}
    
    
    init(numberOfCardsStart: Int, numberOfCardsInDeck: Int,
         cardContentFactory:(Int) -> CardContent){
        
        cards = [Card]()
        deck = [Card]()
        self.numberOfCardsStart = numberOfCardsStart
        for i in 0..<numberOfCardsInDeck{
            let content = cardContentFactory(i)
            deck.append(Card(content: content, id: i)) 
        }
        deck.shuffle()
    }
    
    mutating func deal(_ numberOfCards: Int? = nil) {
        let n = numberOfCards ?? numberOfCardsStart
        for _ in 0..<n {
            cards.append(deck.remove(at: 0))
        }
    }
    

    mutating func choose(card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) ,
           !cards[chosenIndex].isSelected,
           !cards[chosenIndex].isMatched {
            //---------------------- selectedCards Count = 2 -----------------------
            if selectedIndices.count == 2 {
                cards[chosenIndex].isSelected = true
                if CardContent.match(cards: selectedIndices.map {cards[$0].content}){
                    //---------------- Matched ----------------
                    for index in selectedIndices{
                        cards[index].isMatched = true
                    }
                    //---------------- Not matched ----------------
                    
                } else { //
                    for index in selectedIndices {
                        cards[index].isNotMatched = true
                    }
                }
            } else {
                // ---------------- selectedCards count = 0 || 1 || 3 ----------------
                if selectedIndices.count == 1 || selectedIndices.count == 0 {
                    cards[chosenIndex].isSelected = true
                } else{
                    changeCards()
                    onlySelectedCard(chosenIndex)
                }
                // -------------------------------------------------------------------
            }
        }
        
    }
    
    private var matchedIndeces: [Int] {
        cards.indices.filter{ cards[$0].isSelected && cards[$0].isMatched }
    }
    private mutating func changeCards(){
        guard matchedIndeces.count == numberOfCardsToMatch else { return }
        let replaceIndices = matchedIndeces
        if deck.count >= numberOfCardsToMatch && cards.count == numberOfCardsStart{
            // ------------------- Replace matched cards -------------------
            for index in replaceIndices {
                cards.remove(at: index)
                cards.insert(deck.remove(at: 0), at: index)
            }
        } else {
            // ------------------- Remove matched cards -------------------
            cards = cards.enumerated()
                .filter{ !replaceIndices.contains($0.offset)}
                .map { $0.element }
        }
    }

    private mutating func onlySelectedCard(_ onlyIndex: Int){
        for index in cards.indices {
            cards[index].isSelected = index == onlyIndex
            cards[index].isNotMatched = false
        }
    }
    
    struct Card: Identifiable {
        var isSelected: Bool = false
        var isMatched: Bool = false
        var isNotMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

