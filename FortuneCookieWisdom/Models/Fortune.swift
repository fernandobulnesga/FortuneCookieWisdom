//
//  Fortune.swift
//  FortuneCookieWisdom
//
//  Created by Fernando Bulnes Garrorena on 11/17/25.
//

import Foundation

// CONCEPTO: Struct & Codable (Módulo 8 + Persistencia)
struct Fortune: Codable {
    let text: String
    let category: String
    var isFavorite: Bool = false
}
