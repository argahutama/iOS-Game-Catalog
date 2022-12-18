//
//  GamesRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation

protocol GamesRepository {
    func getGames(
        page: Int,
        keyword: String,
        onSuccess: @escaping (_ games: [Game], _ enableLoadMore: Bool) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    )
}
