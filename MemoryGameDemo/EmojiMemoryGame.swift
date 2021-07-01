
//  Created by 兔子 on 2021/6/27.
//

import Foundation

class EmojiMemoryGame: ObservableObject{
    @Published private(set) var GameModel: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String>{
       
        let emojis: Array<String> = ["👻","🎃","🕷️"]
        
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count)
            {
                pairIndex in return emojis[pairIndex]
            }
    }
    
    // var objectWillChange: ObservableObjectPublisher

    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card>{
        
        GameModel.cards
        
    }
    
    // MARK: - Intent
    // choose the card
    func choose(card: MemoryGame<String>.Card){
        // objectWillChange.send()
        GameModel.choose(card: card)
    }
    
    // new game
    func resetGame(){
        GameModel = EmojiMemoryGame.createMemoryGame()
    }
}
