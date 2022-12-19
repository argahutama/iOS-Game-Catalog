//
//  GameDetailRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import RxSwift

final class GameDetailRepositoryImpl: GameDetailRepository {
    private let remoteDataSource: RemoteDataSource

    private init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    static let sharedInstance: (RemoteDataSource) -> GameDetailRepository = { remoteDataSource in
        return GameDetailRepositoryImpl(remoteDataSource: remoteDataSource)
    }

    func getGame(id: Int) -> Observable<GameEntity> {
        return remoteDataSource.getGame(id: id)
            .map { dto in mapGameDtoToEntity(dto) }
    }
}
