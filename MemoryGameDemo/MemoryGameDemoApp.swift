//
//  MemoryGameDemoApp.swift
//  MemoryGameDemo
//
//  Created by 兔子 on 2021/6/27.
//

import SwiftUI

@main
struct MemoryGameDemoApp: App {
    var body: some Scene {
        //let game = EmojiMemoryGame()
        //let contentView = ContentView(viewModel: game)
        
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
