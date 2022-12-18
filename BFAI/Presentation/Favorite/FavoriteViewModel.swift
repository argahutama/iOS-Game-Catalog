//
//  FavoriteViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    init() {
        getFavoriteGames()
    }
    
    let repository = FavoriteGameRepositoryImpl()
    
    @Published var games = [Game]()
    
    func getFavoriteGames() {
        repository.getAllFavoriteGames { games in
            DispatchQueue.main.async { self.games = games }
        }
    }
    
    func removeFavorite(at index: Int) {
        repository.removeFavorite(gameId: games[index].id ?? -1) {
            self.games.remove(at: index)
        }
    }
}
