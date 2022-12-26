//
//  Games.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

struct GameDto: Codable, Identifiable {
    let id: Int?
    let name: String?
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let playtime: Int?
    let genres: [GenreDto]?
    var isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case released
        case backgroundImage = "background_image"
        case rating
        case playtime
        case genres
        case isFavorite
    }
}
