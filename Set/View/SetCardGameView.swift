//
//  ContentView.swift
//  Set
//
//  Created by Evgeniy Nik on 21.02.2022.
//

import SwiftUI

struct SetCardGameView: View {
    @StateObject var viewModel = SetCardGame()
    @State var shouldDelay = true
    
    var body: some View{
        VStack{
            cardsLeft
                .font(.headline)
            gameBody
                .padding(2)
                .background(tableColor.edgesIgnoringSafeArea(.all))
            HStack(spacing:50){
                hint
                dealMore
                restart
            }.font(.headline)
        }
    }
    
    var gameBody: some View {
            GameView(viewModel: viewModel, shouldDelay: $shouldDelay)
                .onAppear{deal()}
    }
    
    var cardsLeft: some View {
        Text("Deck: \(viewModel.cardsInDeck)")
    }
    
    var hint: some View {
        Button (viewModel.numberHint){ viewModel.hint()}.greenRoundStyle()
    }
    
    var dealMore: some View {
        Button ("Deal+3"){ deal3()}.greenRoundStyle()
            .disabled(viewModel.cardsInDeck == 0)
            //.foregroundColor(viewModel.cardsInDeck == 0 ? .gray : .white)
    }
    
    var restart: some View {
        Button("New Game"){newGame()}.greenRoundStyle()
    }
    
    // MARK: - Drawing Constants
    
    private var tableColor: Color{
        Color(UIColor(red: 0, green: 0.5, blue: 0, alpha: 1))}
    
    private func deal(){
        viewModel.deal()
        DispatchQueue.main.async {
            shouldDelay = false
        }
    }
    private func deal3(){
        shouldDelay = true
        viewModel.deal3()
        DispatchQueue.main.async{
            shouldDelay = false
        }
    }
    private func newGame(){
        viewModel.resetGame()
        shouldDelay = true
        deal()
    }
}

struct CardView: View {
    var card: SetGame<SetCard>.Card
    var colorsBorder: [Color] = [.blue,.red,.yellow]
    var colorHint: Color = Color(#colorLiteral(red: 31/255.0, green: 81/255.0, blue: 255/255.0, alpha: 1.0)) // sRGB
    @Binding var setting: Setting
    
    var body: some View {
        if card.isSelected || !card.isMatched{
            SetCardView(card: card.content, setting: setting)
                .background(card.isHint ? setting.colorHint :Color.white)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(highlightColor(), lineWidth: borderLineWidth))
        }
    }
    // MARK: - Drawing Constants & Helper Functions
    
    private let cornerRadius: CGFloat = 10.0
    private let borderLineWidth: CGFloat = 7
    
    private func highlightColor() -> Color {
        var color = Color.white.opacity(0)
        if card.isSelected{
            if card.isMatched{
                color = setting.colorsBorder [0]
            } else if card.isNotMatched{
                color = setting.colorsBorder [1]
            }else{
                color = setting.colorsBorder [2]
                
            }
        }
        return color
    }
}













//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetGameView().preferredColorScheme(.dark)
//        SetGameView().preferredColorScheme(.light)
//    }
//}

struct GameView: View {
    
    @ObservedObject var viewModel: SetCardGame
    @Binding var shouldDelay: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Grid(viewModel.cards) { card in
                CardView(card: card, setting: $viewModel.setting)
                    .transition(.cardTransition(size: geometry.size))
                    .animation(Animation.easeInOut(duration: 1.00)
                        .delay(transitionDelay(card: card)))
                    .onTapGesture {viewModel.choose(card: card)}.padding(2)
            }
        }
    }
    
    // MARK: - Drawing Constants & Helper Functions
    private let cardTransitionDelay : Double = 0.2
    
    private func transitionDelay(card: SetGame<SetCard>.Card) -> Double {
        guard shouldDelay else { return 0 }
        return Double(viewModel.cards.firstIndex(where: {$0.id == card.id} )!) * cardTransitionDelay
    }
}
