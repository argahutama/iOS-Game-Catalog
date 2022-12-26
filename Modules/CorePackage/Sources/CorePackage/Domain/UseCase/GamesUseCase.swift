//
//  GamesUseCase.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation
import RxSwift

public protocol GamesUseCase {
    func getGames(page: Int, keyword: String) -> Observable<PagingEntity<GameEntity>>
}

class GameUseCaseImpl: GamesUseCase {

    private let repository: GamesRepository

    init(repository: GamesRepository) {
        self.repository = repository
    }

    func getGames(page: Int, keyword: String) -> Observable<PagingEntity<GameEntity>> {
        return repository.getGames(page: page, keyword: keyword)
    }
}
