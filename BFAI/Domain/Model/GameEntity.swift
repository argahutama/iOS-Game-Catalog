//
//  GameEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

struct GameEntity {
    let id: Int
    let name: String
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let playtime: Int?
    let genres: [GenreEntity]?
    var isFavorite: Bool
}
