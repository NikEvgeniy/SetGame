//
//  StripedRect.swift
//  Set
//
//  Created by Evgeniy Nik on 05.03.2022.
//

import SwiftUI

struct StripedRect: Shape{
    var spacing: CGFloat = 3.5
    
    func path(in rect: CGRect) -> Path{
        let start = CGPoint (x: rect.minX, y: rect.minY)
        
        var path = Path()
        path.move(to: start)
        while path .currentPoint!.x < rect.maxX{
            path.addLine(to: CGPoint(x: path.currentPoint!.x, y: rect.maxY))
            path .move(to: CGPoint(x: path.currentPoint!.x + spacing, y: rect.minY))
        }
        return path
    }
}

struct StripedRect_Preview: PreviewProvider{
    static var previews: some View{
        ZStack{
            StripedRect().stroke().clipShape(Rhombus())
            Rhombus().stroke(lineWidth: 2)
        }.padding()
    }
}
