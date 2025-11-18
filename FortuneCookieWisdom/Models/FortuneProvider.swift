//
//  FortuneProvider.swift
//  FortuneCookieWisdom
//
//  Created by Fernando Bulnes Garrorena on 11/17/25.
//

import Foundation

struct FortuneProvider {
    
    static var favoriteFortunes: [Fortune] {
        get {
            if let data = UserDefaults.standard.data(forKey: "savedFortunes"),
               let decoded = try? JSONDecoder().decode([Fortune].self, from: data) {
                return decoded
            }
            return []
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "savedFortunes")
            }
        }
    }
    
    private let quotes = [
        "Success is not the key to happiness. Happiness is the key to success.",
        "Do not count the days, make the days count.",
        "The best way to predict the future is to create it.",
        "Believe you can and you're halfway there.",
        "Sometimes you win, sometimes you learn.",
        "The only way to do great work is to love what you do.",
        "Your attitude, not your aptitude, will determine your altitude.",
        "If you can dream it, you can do it.",
        "Patience is bitter, but its fruit is sweet.",
        "Do not find fault, find a remedy."
    ]
    
    func getRandomFortune() -> Fortune {
        let randomQuote = quotes.randomElement() ?? "Today is your lucky day."
        return Fortune(text: randomQuote, category: "General", isFavorite: false)
    }
}
