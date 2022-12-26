//
//  GamesRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import Alamofire
import RxSwift

final class GamesRepositoryImpl: GamesRepository {
    private let remoteDataSource: RemoteDataSource

    private init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    static let sharedInstance: (RemoteDataSource) -> GamesRepository = { remoteDataSource in
        return GamesRepositoryImpl(remoteDataSource: remoteDataSource)
    }

    func getGames(page: Int, keyword: String) -> Observable<PagingEntity<GameEntity>> {
        return remoteDataSource.getGames(page: page, keyword: keyword)
            .map { response in mapGamesResponseToPagingEntity(response) }
    }
}
