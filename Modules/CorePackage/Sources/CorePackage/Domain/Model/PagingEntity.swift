//
//  PagingEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

public struct PagingEntity<T> {
    public init(items: [T], count: Int, nextPageUrl: String?, previousPageUrl: String?) {
        self.items = items
        self.count = count
        self.nextPageUrl = nextPageUrl
        self.previousPageUrl = previousPageUrl
    }

    public let items: [T]
    public let count: Int
    public let nextPageUrl: String?
    public let previousPageUrl: String?

    public func isEnableLoadMore() -> Bool {
        return !(nextPageUrl ?? "").isEmpty
    }
}
