//
//  Game.swift
//  BFAI
//
//  Created by Arga Hutama on 21/12/22.
//

import Foundation

struct Game: Identifiable {
    let id: Int
    let name: String
    let description: String
    let released: String
    let backgroundImage: String
    let rating: Double?
    let playtime: Int
    let genreNames: [String]
    var isFavorite: Bool
}
