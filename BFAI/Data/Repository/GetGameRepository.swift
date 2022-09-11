//
//  GameRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

protocol GetGamesDelegate {
    func didUpdateGamess(_ repository: GetGameRepository, games: [Game])
    func didFailWithError(error: Error)
}

class GetGameRepository {
    var delegate: GetGamesDelegate? = nil
    
    func getGames(page: Int) {
        performRequest(page: page)
    }
    
    private func performRequest(page: Int) {
        let url = Config.baseUrl + "games"
        
        var components = URLComponents(string: url)!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: Config.apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
            }
            if let safeData = data {
                if let games = self.parseJSON(safeData) {
                    self.delegate?.didUpdateGamess(self, games: games)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> [Game]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(GetGameResponse.self, from: data)
            return decodedData.results
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
