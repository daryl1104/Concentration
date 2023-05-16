//
//  Concentration.swift
//  Concentration
//
//  Created by daryl on 2023/5/15.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in
                return cards[index].isFaceUp
            }.oneAndOnly
            
            // closure
//            let foundIndex = cards.indices.filter { index in
//                return cards[index].isFaceUp
//            }.
//            return foundIndex.count == 1 ? foundIndex.first : nil
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        // three conditions
        // 1: one flipped over
        // 2. two flipped over
        // 3. none flipped over
        
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                // check if card match
                if cards[matchedIndex] == cards[index] {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // flip two to face down
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                // let all cards face down except current one
                indexOfOneAndOnlyFaceUpCard = index
            }
            
            
        }
        
        
    }
    
    init(numbersOfPairsOfCard: Int) {
        // init card var
        for _ in 0..<numbersOfPairsOfCard {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        // TODO: shuffle cards array
        
        
    }
    
    func flipCard() {
        
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
