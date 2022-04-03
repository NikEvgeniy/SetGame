//
//  Transiotion+Extensions.swift
//  Set
//
//  Created by Evgeniy Nik on 03.04.2022.
//

import SwiftUI

public extension AnyTransition {
    static func cardTransition(size:CGSize) -> AnyTransition {
        let insertion = AnyTransition.offset(flyFrom(for: size))
        let removal = AnyTransition.offset(flyTo(for: size))
            .combined(with: AnyTransition.scale(scale: 0.5))
        return .asymmetric(insertion: insertion, removal: removal)
    }
    static func flyFrom(for size: CGSize) -> CGSize {
        CGSize(width: 0.0 /*CGFloat.random(in: -size.width/2...size.width/2)*/,
               height: size.height)
    }
    
    static func flyTo(for size:CGSize) -> CGSize {
        CGSize(width: CGFloat.random(in: -3*size.width...3*size.width),
               height: CGFloat.random(in: -2*size.height...(-size.height)))
    }
    
}
