//
//  RemoteDataSource.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSource {
    func getGames(page: Int, keyword: String) -> Observable<(GetGamesResponse)>
    func getGame(id: Int) -> Observable<GameDto>
}

final class RemoteDataSourceImpl: RemoteDataSource {
    static let sharedInstance: () -> RemoteDataSource = {
        return RemoteDataSourceImpl()
    }

    func getGames(page: Int, keyword: String) -> Observable<GetGamesResponse> {
        return Observable<GetGamesResponse>.create { observer in
            let url = Config.baseUrl + "games"

            let parameters: Parameters = [
                "key": Config.getApiKey(),
                "search": keyword,
                "page": String(page),
                "page_size": String(10)
            ]

            AF.request(
                url,
                parameters: parameters
            ).validate().responseDecodable(
                of: GetGamesResponse.self
            ) { response in
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

    func getGame(id: Int) -> Observable<GameDto> {
        return Observable<GameDto>.create { observer in
            let url = Config.baseUrl + "games/\(id)"

            let parameters: Parameters = [
                "key": Config.getApiKey()
            ]

            AF.request(url, parameters: parameters).validate().responseDecodable(of: GameDto.self) { response in
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
