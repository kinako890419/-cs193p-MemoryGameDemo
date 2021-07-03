//  Created by 兔子 on 2021/6/26.
//  lecture 2 hw : shuffle & more cards

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }.padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90))
                    }
                }
                .padding(5)
                .opacity(0.4)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}


//import SwiftUI
//
//struct EmojiMemoryGameView: View {// constraints and gains : constraints
//
//    @ObservedObject var viewModel: EmojiMemoryGame //objectwillchange -> redraw
//    var body: some View {
//        VStack{
//            Grid(viewModel.cards){
//                // var is not allowed to build in view builders
//                    card in
//                    CardView(card: card).onTapGesture{
//                        withAnimation(.easeInOut(duration: 0.8)){
//                            // flip card animation
//                            //self.
//                            viewModel.choose(card: card)
//                        }
//                    }.padding(5)
//            }
//            // constraints and gains: gains
//            .padding()
//            .foregroundColor(Color.orange)
//            // concept of declarative v.s imperative
//
//            // new game button
//            Button(action: {
//                withAnimation(.easeInOut(duration: 0.8)){// shuffle animation
//                    self.viewModel.resetGame()
//                }
//            }, label: {Text ("New Game")})
//            // research: localize String
//        }
//    }
//}
//
////presents single card
//struct CardView: View{
//
//    let card: MemoryGame<String>.Card
//    var body: some View {
//        GeometryReader{
//            geometry in self.body(for: geometry.size)
//        }
//    }
//
//    // private let fontScaleFactor: CGFloat = 0.7
//    private func fontSize(for size: CGSize) -> CGFloat{
//        min(size.width,size.height) * 0.7
//    }
//
//    @State private var animatedBonusRemaining: Double = 0
//    private func startBonusTimeAnimation(){
//        animatedBonusRemaining = card.bonusRemaining
//        withAnimation(.linear(duration: card.bonusRemaining)){
//            animatedBonusRemaining = 0
//        }
//    }
//
//    @ViewBuilder
//    private func body(for size: CGSize) -> some View{
//        if card.isFaceUp || !card.isMatched{
//            // @ViewBuilder -> a list of views
//            ZStack{
//                Group{
//                    if card.isConsumingBonusTime{
//                        // count down pie
//                        //Circle().padding(5).opacity(0.4)
//                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))//,clockWise: true)
//                            .onAppear{
//                                self.startBonusTimeAnimation()
//                            }
//                    }
//                    else{
//                        Pie(startAngle: Angle.degrees(-90),
//                            endAngle: Angle.degrees(-card.bonusRemaining*360-90))//,clockWise: true)
//                    }
//                }.padding(5).opacity(0.4)//.transition(.scale)
//
//                // emoji
//                Text(card.content).font(Font.system(size: fontSize(for: size)))
//                //.font(Font.largeTitle
//                // rotation effect: 360 degrees rotation
//                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
//                    .animation(card.isMatched ? Animation.linear(duration: 0.8).repeatForever(autoreverses: false): .default)
//            }
//            .cardify(isFaceUp: card.isFaceUp)
//            //.modifier(Cardify(isFaceUp: card.isFaceUp))
//            .transition(.scale) // card disappear animation
//            //.transition(AnyTransition.scale)
//        }
//
//
//    }
//
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        // check in canvas
//        let game = EmojiMemoryGame()
//        game.choose(card: game.cards[0])
//        return EmojiMemoryGameView(viewModel: game)
//    }
//}
