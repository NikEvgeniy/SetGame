//
//  Extensions.swift
//  Set
//
//  Created by Evgeniy Nik on 07.03.2022.
//

import SwiftUI

extension Shape{
    func stripe(_ lineWidth: CGFloat = 2) -> some View{
        ZStack{
            StripedRect().stroke().clipShape(self)
            self.stroke(lineWidth: lineWidth)
        }
    }
    func blur(_ lineWidth: CGFloat = 2) -> some View{
        ZStack{
            self.fill().opacity(0.25)
            self.stroke(lineWidth: lineWidth)
        }
    }
    func fillAndBorder(_ lineWidth: CGFloat = 2 ) -> some View{
        ZStack{
            self.fill()
            self.stroke(lineWidth: lineWidth)
        }
    }
}

