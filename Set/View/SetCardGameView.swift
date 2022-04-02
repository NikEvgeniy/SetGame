//
//  ContentView.swift
//  Set
//
//  Created by Evgeniy Nik on 21.02.2022.
//

import SwiftUI

struct SetCardGameView: View {
    @StateObject var viewModel = SetCardGame()
    
    var body: some View{
        Grid(viewModel.cards) { card in
            CardView (card: card)
                .onTapGesture {viewModel.choose(card: card)}
                .padding(2)
        }
        .onAppear{viewModel.deal()}
        .padding(2)
        .background(tableColor.edgesIgnoringSafeArea(.all) )
    }
    // MARK: - Drawing Constants
    private var tableColor: Color{
        Color(UIColor(red: 0, green: 0.5, blue: 0, alpha: 1))}
}

struct CardView: View {
    var card: SetGame<SetCard>.Card
    
    var body: some View {
        if card.isSelected || !card.isMatched{
            SetCardView(card: card.content)
                .background(Color.white)
                .cornerRadius(cornerRadius)
        }
    }
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10.0
}













//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetGameView().preferredColorScheme(.dark)
//        SetGameView().preferredColorScheme(.light)
//    }
//}
