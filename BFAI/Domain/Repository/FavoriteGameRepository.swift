//
//  FavoriteGameRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import RxSwift

protocol FavoriteGameRepository {
    func getAllFavoriteGames() -> Observable<[Game]>
    func addFavorite(game: Game) -> Observable<Void>
    func findData(gameId: Int) -> Observable<Bool>
    func removeFavorite(gameId: Int) -> Observable<Void>
}
