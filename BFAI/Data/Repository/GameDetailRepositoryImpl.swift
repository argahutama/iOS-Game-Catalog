//
//  GetGameDetailRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class GameDetailRepositoryImpl: GameDetailRepository {
    func getGame(
        id: Int,
        onSuccess: @escaping (_ game: Game?) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        performRequest(
            id: id,
            onSuccess: onSuccess,
            onFailure: onFailure
        )
    }
    
    private func performRequest(
        id: Int,
        onSuccess: @escaping (_ game: Game?) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        let url = Config.baseUrl + "games/\(id)"
        
        var components = URLComponents(string: url)!
        components.queryItems = [URLQueryItem(name: "key", value: Config.apiKey)]
        
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
                    onSuccess: onSuccess,
                    onFailure: onFailure
                )
            }
        }
        task.resume()
    }
    
    private func parseJSON(
        _ data: Data,
        onSuccess: @escaping (_ game: Game?) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Game.self, from: data)
            onSuccess(decodedData)
        } catch {
            onFailure(error)
        }
    }
}
