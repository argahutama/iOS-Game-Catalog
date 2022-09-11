//
//  Games.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: Int?
    let slug: String?
    let name: String?
    let description: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount, added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [CommonModel]?
    let stores: [Store]?
    let tags: [CommonModel]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, description, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}

struct ParentPlatform: Codable {
    let platform: EsrbRating?
}

struct PlatformElement: Codable {
    let platform: PlatformPlatform?
    let releasedAt: String??
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

struct PlatformPlatform: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let image: String?
    let yearEnd: Int?
    let yearStart: Int?
    let gamesCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
    }
}

struct Requirements: Codable {
    let minimum: String?
    let recommended: String?
}

struct Rating: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?
}

struct Store: Codable {
    let id: Int?
    let store: CommonModel?
}
