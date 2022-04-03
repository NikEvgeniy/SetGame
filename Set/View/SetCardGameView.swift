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
        GeometryReader { geometry in
            Grid(viewModel.cards) { card in
                CardView (card: card)
                    .transition(AnyTransition.asymmetric(
                        insertion: AnyTransition.offset(flyFrom(for: geometry.size)),
                        removal: AnyTransition.offset(flyTo(for:geometry.size))
                            .combined(with: AnyTransition.scale(scale: 0.5))))
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.00)){
                        viewModel.choose(card: card)
                        }
                    }.padding(2)
            } .onAppear{
                withAnimation(Animation.easeInOut(duration: 1.0)){
                    viewModel.deal()
                }
            }
            .padding(2)
            .background(tableColor.edgesIgnoringSafeArea(.all) )
        }
    }
    // MARK: - Drawing Constants
    private var tableColor: Color{
        Color(UIColor(red: 0, green: 0.5, blue: 0, alpha: 1))}
    
    private func flyFrom(for size: CGSize) -> CGSize {
        CGSize(width: 0.0 /*CGFloat.random(in: -size.width/2...size.width/2)*/,
               height: size.height)
    }
    
    private func flyTo(for size:CGSize) -> CGSize {
        CGSize(width: CGFloat.random(in: -3*size.width...3*size.width),
                   height: CGFloat.random(in: -2*size.height...(-size.height)))
    }
}

struct CardView: View {
    var card: SetGame<SetCard>.Card
    var colorsBorder: [Color] = [.blue,.red,.yellow]
    
    var body: some View {
        if card.isSelected || !card.isMatched{
            SetCardView(card: card.content)
                .background(Color.white)
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
                color = colorsBorder [0]
            } else if card.isNotMatched{
                color = colorsBorder [1]
            }else{
                color = colorsBorder [2]
                
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
