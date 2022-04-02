//
//  SetCardView.swift
//  Set
//
//  Created by Evgeniy Nik on 07.03.2022.
//

import SwiftUI

struct SetCardView: View {
    var card: SetCard
    var colorsShapes: [Color] = [.green,.red,.purple]
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                Spacer()
                ForEach(0..<card.number.rawValue) { index in
                    cardShape().frame(height: geo.size.height/4)
                }
                Spacer()
            }
        }.padding(10)
            .foregroundColor(colorsShapes[card.color.rawValue - 1])
            .aspectRatio(CGFloat(6.0/8.0), contentMode: .fit)
    }
    
    @ViewBuilder private func cardShape() -> some View {
        switch card.shape {
        case .v1 :  shapeFill(shape: Rhombus())
        case .v2 :  shapeFill(shape: Capsule())
        case .v3 :  shapeFill(shape: Squiggle())
        }
    }
    
    @ViewBuilder private func shapeFill<setShape>(shape: setShape)-> some View
    where setShape: Shape {
        ZStack{
            switch card.fill {
            case .v1: shape.stroke(lineWidth: lineWidth)
            case .v2: shape.fillAndBorder(lineWidth)
            case .v3: shape.stripe(lineWidth)
            }
        }
    }
    // MARK: - Drawing Constants
    private let lineWidth: CGFloat = 3
    
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardView( card: SetCard (number:.v3, color: .v3, shape: .v3, fill: .v3))
            .overlay(
                RoundedRectangle( cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding()
    }
}
