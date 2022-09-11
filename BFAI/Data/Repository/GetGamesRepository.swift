//
//  GameRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

protocol GetGamesDelegate {
    func didUpdateGames(_ repository: GetGamesRepository, games: [Game], enableLoadMore: Bool)
    func didLoadMoreGames(_ repository: GetGamesRepository, games: [Game], enableLoadMore: Bool)
    func didUpdateFailWithError(error: Error)
    func didLoadMoreFailWithError(error: Error)
}

class GetGamesRepository {
    var delegate: GetGamesDelegate? = nil
    
    func getGames(page: Int) {
        performRequest(page: page)
    }
    
    private func performRequest(page: Int) {
        let url = Config.baseUrl + "games"
        
        var components = URLComponents(string: url)!
        
        components.queryItems = [
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
                if page == 1 {
                    self.delegate?.didUpdateFailWithError(error: error!)
                } else {
                    self.delegate?.didLoadMoreFailWithError(error: error!)
                }
            }
            if let safeData = data {
                if let response = self.parseJSON(safeData) {
                    let games = response.results ?? []
                    let enableLoadMore = !(response.next ?? "").isEmpty
                    
                    if page == 1 {
                        self.delegate?.didUpdateGames(
                            self,
                            games: games,
                            enableLoadMore: enableLoadMore
                        )
                    } else {
                        self.delegate?.didLoadMoreGames(
                            self,
                            games: games,
                            enableLoadMore: enableLoadMore
                        )
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> GetGamesResponse? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(GetGamesResponse.self, from: data)
            return decodedData
        } catch {
            delegate?.didUpdateFailWithError(error: error)
            return nil
        }
    }
}
