//
//  GameDetailUseCase.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation
import RxSwift

public protocol GameDetailUseCase {
    func getGame(id: Int) -> Observable<GameEntity>
}

class GameDetailUseCaseImpl: GameDetailUseCase {
    private let repository: GameDetailRepository

    init(repository: GameDetailRepository) {
        self.repository = repository
    }

    func getGame(id: Int) -> Observable<GameEntity> {
        return repository.getGame(id: id)
    }
}
