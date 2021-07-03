//
//  MemoryGame.swift
//  testApp
//
//  Created by 兔子 on 2021/6/27.
//  model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: Array<Card>
    // setting it is private, but reading it is not
    
    private var indexOfTheOneAndTheOnlyFaceUpCard: Int?{
        get{
            //var faceUpCardIndices = [Int]() //= Array<Int>[]
            cards.indices.filter {cards[$0].isFaceUp}.only
            
            /*for index in cards.indices{
                if cards[index].isFaceUp{
                    faceUpCardIndices.append(index)
                }
            }*/
            
            /**if faceUpCardIndices.count == 1{
                return faceUpCardIndices.first // faceUpCardIndices[0]
            }
            else{
                return nil
            }*/
        }
        set{
            for index in cards.indices{ // index的複數
                
                cards[index].isFaceUp = index == newValue
                /*if index == newValue{
                    cards[index].isFaceUp = true

                }
                else{
                    cards[index].isFaceUp = false

                }*/
            }
        }
    }
    
    mutating func choose(card: Card){
    
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{ // 逗號：sequential &&（先做前面在做後面）
            
            if let potentialMatchedIndex = indexOfTheOneAndTheOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchedIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                }
                //indexOfTheOneAndTheOnlyFaceUpCard = nil
                self.cards[chosenIndex].isFaceUp = true
            }
            else{
                /**for index in cards.indices{
                    cards[index].isFaceUp = false
                }**/
                indexOfTheOneAndTheOnlyFaceUpCard = chosenIndex
            }
            
        }
    }
    
    /**func index(of cards: Card) -> Int {
        
        for index in 0..<self.cards.count{
            
            if self.cards[index].id == cards.id{
                return index
            }
        }
        // if did'nt find the card
        return 0 // TODO: return 0 is wrong
    }**/
    
    // create memory game (initialize)
    // cardContentFactory: make the card content
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) ->CardContent) {
        
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
            // cards.shuffle()
        }
        cards.shuffle()
    }
    
    // structure of the Card
    struct Card: Identifiable {
        
        var isFaceUp: Bool = false{
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                }
                else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false{
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        
        // MARK: - Bonus Time
        // this could give matches bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        //can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6

        //how long this card has ever been face up
        private var faceUpTime: TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else{
                return pastFaceUpTime
            }
        }

        // the last time this card was turned face up(and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in past
        // (i.e not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0

        // how much time left befor the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval{
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double{
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool{
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool{
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        // called when the card transitions to face up state
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil{
                lastFaceUpDate = Date()
            }
        }

        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
    
}
