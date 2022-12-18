//
//  GetGameDetailRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import Alamofire

class GameDetailRepositoryImpl: GameDetailRepository {
    func getGame(
        id: Int,
        onSuccess: @escaping (_ game: Game?) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    ) {
        let url = Config.baseUrl + "games/\(id)"
        
        let parameters: Parameters = [
            "key": Config.apiKey
        ]
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: Game.self) { response in
            switch response.result {
            case .success(let value):
                onSuccess(value)
            case .failure:
                onFailure(response.error!)
            }
        }
    }
}
