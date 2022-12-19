//
//  FavoriteGameRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import Foundation
import RxSwift

final class FavoriteGameRepositoryImpl: FavoriteGameRepository {
    private let localDataSource: LocalDataSource
    
    private init(localDataSource: LocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    static let sharedInstance: (LocalDataSource) -> FavoriteGameRepository = { localDataSource in
        return FavoriteGameRepositoryImpl(localDataSource: localDataSource)
    }
    
    func getAllFavoriteGames() -> Observable<[Game]> {
        return localDataSource.getAllFavoriteGames()
    }
    
    func addFavorite(game: Game) -> Observable<Void> {
        return localDataSource.addFavorite(game: game)
    }
    
    func findData(gameId: Int) -> Observable<Bool> {
        return localDataSource.findGameData(gameId: gameId)
    }
    
    func removeFavorite(gameId: Int) -> Observable<Void> {
        return localDataSource.removeFavorite(gameId: gameId)
    }
}
