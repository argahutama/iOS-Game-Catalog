//
//  CommonEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

struct GenreEntity: Identifiable {
    let id: Int
    let name: String
    let slug: String
    let domain: String?
    let language: String?
}
