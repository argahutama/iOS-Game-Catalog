//
//  FavoriteGameUseCase.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation
import RxSwift

public protocol FavoriteGameUseCase {
    func getAllFavoriteGames() -> Observable<[GameEntity]>
    func addFavorite(game: GameEntity) -> Observable<Void>
    func findData(gameId: Int) -> Observable<Bool>
    func removeFavorite(gameId: Int) -> Observable<Void>
}

class FavoriteGameUseCaseImpl: FavoriteGameUseCase {
    private let repository: FavoriteGameRepository

    init (repository: FavoriteGameRepository) {
        self.repository = repository
    }

    func getAllFavoriteGames() -> Observable<[GameEntity]> {
        return repository.getAllFavoriteGames()
    }

    func addFavorite(game: GameEntity) -> Observable<Void> {
        return repository.addFavorite(game: game)
    }

    func findData(gameId: Int) -> Observable<Bool> {
        return repository.findData(gameId: gameId)
    }

    func removeFavorite(gameId: Int) -> Observable<Void> {
        return repository.removeFavorite(gameId: gameId)
    }
}
