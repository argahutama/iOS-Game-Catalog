//
//  GamesRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import RxSwift

protocol GamesRepository {
    func getGames(page: Int, keyword: String) -> Observable<PagingEntity<GameEntity>>
}
