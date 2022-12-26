//
//  GetGameResponse.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

struct GetGamesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameDto]?
    let seoTitle: String?
    let seoDescription: String?
    let seoKeywords: String?
    let seoH1: String?
    let noindex, nofollow: Bool?
    let welcomeDescription: String?
    let filters: Filters?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case welcomeDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

struct Filters: Codable {
    let years: [FiltersYear]?
}

struct FiltersYear: Codable {
    let from, until: Int?
    let filter: String?
    let decade: Int?
    let years: [YearYear]?
    let nofollow: Bool?
    let count: Int?
}

struct YearYear: Codable {
    let year, count: Int?
    let nofollow: Bool?
}
