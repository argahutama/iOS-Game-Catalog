//
//  GetGameDetailRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

protocol GetGameDetailDelegate {
    func didUpdateGame(_ repository: GetGameDetailRepository, game: Game?)
    func didUpdateFailWithError(error: Error)
}

class GetGameDetailRepository {
    var delegate: GetGameDetailDelegate? = nil
    
    func getGame(id: Int) {
        performRequest(id: id)
    }
    
    private func performRequest(id: Int) {
        let url = Config.baseUrl + "games/\(id)"
        
        var components = URLComponents(string: url)!
        components.queryItems = [URLQueryItem(name: "key", value: Config.apiKey)]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                self.delegate?.didUpdateFailWithError(error: error!)
            }
            if let safeData = data {
                if let response = self.parseJSON(safeData) {
                    self.delegate?.didUpdateGame(
                        self,
                        game: response
                    )
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> Game? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Game.self, from: data)
            return decodedData
        } catch {
            delegate?.didUpdateFailWithError(error: error)
            return nil
        }
    }
}
