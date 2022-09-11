//
//  Developer.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

struct CommonModel: Codable, Identifiable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}
