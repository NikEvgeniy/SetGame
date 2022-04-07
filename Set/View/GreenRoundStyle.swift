//
//  GreenRoundStyle.swift
//  Set
//
//  Created by Evgeniy Nik on 07.04.2022.
//

import SwiftUI

struct GreenRoundButton: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                .stroke(Color.green, lineWidth: 3))
    }
}

extension View {
    func greenRoundStyle() -> some View{
        self.modifier(GreenRoundButton())
    }
}
