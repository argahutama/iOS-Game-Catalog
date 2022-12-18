//
//  GameRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import Alamofire

class GamesRepositoryImpl: GamesRepository {
    func getGames(
        page: Int,
        keyword: String,
        onSuccess: @escaping (_ games: [Game], _ enableLoadMore: Bool) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        let url = Config.baseUrl + "games"
        
        let parameters: Parameters = [
            "key": Config.apiKey,
            "search": keyword,
            "page": String(page),
            "page_size": String(10)
        ]
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: GetGamesResponse.self) { response in
            switch response.result {
            case .success(let value):
                let games = value.results ?? []
                let enableLoadMore = !(value.next ?? "").isEmpty
                onSuccess(games, enableLoadMore)
            case .failure:
                onFailure(response.error!)
            }
        }
    }
}
