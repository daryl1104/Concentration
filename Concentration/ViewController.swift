//
//  ViewController.swift
//  Concentration
//
//  Created by daryl on 2023/5/14.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numbersOfPairsOfCard: numbersOfPairsOfCard)
    var numbersOfPairsOfCard: Int {
        get {
            return (cardButtons.count+1) / 2
        }
    }

    @IBOutlet var flipCountLabel: UILabel! {
        didSet{
            updateFlipCount()
        }
    }
    var flipCount = 0 {
        didSet {
            updateFlipCount()
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func cardTapped(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtons.lastIndex(of: sender) {
//            flip(withEmoji: emojis[cardIndex], on: sender)
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }else {
            print("button is not included in the collection.")
        }
        
    }
    
    private func updateFlipCount() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.white
        ]
        let attributedString = NSAttributedString(string: "flipCount: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor(white: 0, alpha: 0) : UIColor.orange
            }
        }
        
    }
    
    var emojis = ["🎃","👻","🦖","🐖","🌵","🌺","🌍","🍔","🧸"]
    var emojis1 = "🎃👻🦖🐖🌵🌺🌍🍔🧸"

    var emoji = [Card: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojis.count > 0 {
            // put a emoji into dictionary
            emoji[card] = emojis.remove(at: emojis.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
