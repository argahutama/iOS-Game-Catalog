//
//  GamesUseCase.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation
import RxSwift

protocol GamesUseCase {
    func getGames(page: Int, keyword: String) -> Observable<GetGamesResponse>
}

class GameUseCaseImpl: GamesUseCase {
    
    private let repository: GamesRepository
    
    init(repository: GamesRepository) {
        self.repository = repository
    }
    
    func getGames(page: Int, keyword: String) -> Observable<GetGamesResponse> {
        return repository.getGames(page: page, keyword: keyword)
    }
}
