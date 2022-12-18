//
//  GameRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class GamesRepositoryImpl: GamesRepository {
    func getGames(
        page: Int,
        keyword: String,
        onSuccess: @escaping (_ games: [Game], _ enableLoadMore: Bool) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        performRequest(
            page: page,
            keyword: keyword,
            onSuccess: onSuccess,
            onFailure: onFailure
        )
    }
    
    private func performRequest(
        page: Int,
        keyword: String,
        onSuccess: @escaping (_ games: [Game], _ enableLoadMore: Bool) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        let url = Config.baseUrl + "games"
        
        var components = URLComponents(string: url)!
        
        components.queryItems = [
            URLQueryItem(name: "search", value: keyword),
            URLQueryItem(name: "key", value: Config.apiKey),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "page_size", value: String(10))
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                onFailure(error!)
            }
            if let safeData = data {
                self.parseJSON(
                    safeData,
                    onSuccess: { response in
                        let games = response.results ?? []
                        let enableLoadMore = !(response.next ?? "").isEmpty
                        onSuccess(games, enableLoadMore)
                    },
                    onFailure: onFailure
                )
            }
        }
        task.resume()
    }
    
    private func parseJSON(
        _ data: Data,
        onSuccess: @escaping (_ response: GetGamesResponse) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(GetGamesResponse.self, from: data)
            onSuccess(decodedData)
        } catch {
            onFailure(error)
        }
    }
}
