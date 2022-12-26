//
//  CommonEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

public struct GenreEntity: Identifiable {
    public init(id: Int, name: String, slug: String, domain: String?, language: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.domain = domain
        self.language = language
    }

    public let id: Int
    public let name: String
    public let slug: String
    public let domain: String?
    public let language: String?
}
