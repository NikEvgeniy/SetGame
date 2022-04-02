//
//  SetApp.swift
//  Set
//
//  Created by Evgeniy Nik on 21.02.2022.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetCardGameView(viewModel: SetCardGame())
        }
    }
}


