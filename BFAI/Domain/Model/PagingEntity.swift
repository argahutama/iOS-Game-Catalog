//
//  PagingEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

struct PagingEntity<T> {
    let items: [T]
    let count: Int
    let nextPageUrl: String?
    let previousPageUrl: String?
}
