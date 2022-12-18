//
//  FavoriteGameRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation

protocol FavoriteGameRepository {
    func getAllFavoriteGames(completion: @escaping(_ games: [Game]) -> Void)
    func addFavorite(game: Game, completion: @escaping () -> Void)
    func findData(gameId: Int, completion: @escaping (_ isExist: Bool) -> Void)
    func removeFavorite(gameId: Int, completion: @escaping () -> Void)
}
