//
//  GamesRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import Alamofire
import RxSwift

class GamesRepositoryImpl: GamesRepository {
    func getGames(page: Int, keyword: String) -> Observable<GetGamesResponse> {
        return Observable<GetGamesResponse>.create { observer in
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
