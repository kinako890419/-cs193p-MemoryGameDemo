//
//  Cardify.swift
//  MemoryGameDemo
//
//  Created by 兔子 on 2021/6/30.
//

import SwiftUI

struct Cardify: AnimatableModifier {// ViewModifier, Animatable
    var rotation: Double
    var isFaceUp: Bool{
        rotation < 90
    }
    init(isFaceUp: Bool){
        // is faced up -> 0, otherwise 180
        rotation = isFaceUp ? 0:180
    }
    var animatableData: Double{
        get{
            return rotation
        }
        set{
            rotation = newValue
        }
    }
    // MARK: - Drawing Constraints
    // clean up codes
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    func body(content: Content) -> some View {
        ZStack{
            //if isFaceUp{ // if card.isFaceUp
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    
                content
            }.opacity(isFaceUp ? 1:0)
                    /**if !card.isMatched{
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }*/
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0:1)
            
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0)) // flip rotation
    }
}

extension View{
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
