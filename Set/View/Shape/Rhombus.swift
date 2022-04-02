//
//  Rhombus.swift
//  Set
//
//  Created by Evgeniy Nik on 23.02.2022.
//

import SwiftUI

struct Rhombus: Shape {
    
    func path ( in rect: CGRect ) -> Path{
        var path = Path()
        let top = CGPoint (x: rect.midX, y: rect.minY)
        let bottom = CGPoint (x: rect.midX, y: rect.maxY)
        let left = CGPoint (x: rect.minX, y: rect.midY)
        let right = CGPoint (x: rect.maxX, y: rect.midY)
        
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: bottom)
        path.addLine(to: right)
        path.addLine(to: top)
        
        return path
        
    }
}



struct Rhombus_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Rhombus().stroke(lineWidth: 5)
            Rhombus().fill()
            ZStack{
                Rhombus().fill().opacity(0.25)
                Rhombus().stroke(lineWidth: 5)
                
            }
        }.padding()
    }
}
