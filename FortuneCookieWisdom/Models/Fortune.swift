//
//  Fortune.swift
//  FortuneCookieWisdom
//
//  Created by Fernando Bulnes Garrorena on 11/17/25.
//

import Foundation

struct Fortune: Codable {
    let text: String
    let category: String
    var isFavorite: Bool = false
}
