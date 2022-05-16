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
    var setting: Setting
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                Spacer()
                ForEach(0..<card.number.rawValue, id: \.self) { index in
                    cardShape().frame(height: geo.size.height/4)
                }
                Spacer()
            }
        }.padding(10)
            .foregroundColor(colorsShapes[card.color.rawValue - 1])
            .aspectRatio(CGFloat(6.0/8.0), contentMode: .fit)
    }
    
    @ViewBuilder private func cardShape() -> some View {
        switch shapeInSet(card: card) {
        case .rhombus :     shapeFill(shape: Rhombus())
        case .oval :        shapeFill(shape: Capsule())
        case .squiggle :    shapeFill(shape: Squiggle())
        case .rainDrop :    shapeFill(shape: RainDrop())
        }
    }
    
    @ViewBuilder private func shapeFill<setShape>(shape: setShape)-> some View
    where setShape: Shape {
        ZStack{
            switch fillInSet(card: card) {
            case .stroke:   shape.stroke(lineWidth: shapeLineWidth)
            case .fill:     shape.fillAndBorder()
            case .stripe:   shape.stripe()
            case .blur:     shape.blur()
            }
        }
    }
    // MARK: - Drawing Constants
    private let shapeLineWidth: CGFloat = 3
    
    private func fillInSet(card: SetCard) -> FillInSet {
        setting.fillShapes[card.fill.rawValue - 1 ]
    }
    
    private func shapeInSet(card: SetCard) -> ShapesInSet{
        setting.shapes[card.shape.rawValue - 1]
    }
    
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardView( card: SetCard (number:.v3, color: .v1, shape: .v3, fill: .v2), setting: Setting())
            .overlay(
                RoundedRectangle( cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding()
    }
}
