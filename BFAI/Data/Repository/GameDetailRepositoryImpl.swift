//
//  GameDetailRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import Alamofire
import RxSwift

class GameDetailRepositoryImpl: GameDetailRepository {
    func getGame(id: Int) -> Observable<Game> {
        return Observable<Game>.create { observer in
            let url = Config.baseUrl + "games/\(id)"
            
            let parameters: Parameters = [
                "key": Config.apiKey
            ]
            
            AF.request(url, parameters: parameters).validate().responseDecodable(of: Game.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure:
                    observer.onError(response.error!)
                }
            }
            
            return Disposables.create()
        }
    }
}
