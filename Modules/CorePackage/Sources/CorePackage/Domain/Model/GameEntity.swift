//
//  GameEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

public struct GameEntity {
    public init(
        id: Int,
        name: String,
        description: String?,
        released: String?,
        backgroundImage: String?,
        rating: Double?,
        playtime: Int?,
        genres: [GenreEntity]?,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.playtime = playtime
        self.genres = genres
        self.isFavorite = isFavorite
    }

    public let id: Int
    public let name: String
    public let description: String?
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let playtime: Int?
    public let genres: [GenreEntity]?
    public var isFavorite: Bool
}
