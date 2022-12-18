//
//  DetailViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    let repository: GameDetailRepository = GameDetailRepositoryImpl()
    let favGameRepository: FavoriteGameRepositoryImpl = FavoriteGameRepositoryImpl()
    
    @Published var game: Game? = nil
    @Published var error: Error? = nil
    @Published var loading = true
    
    func getGameDetail(id: Int) {
        repository.getGame(
            id: id,
            onSuccess: { game in
                DispatchQueue.main.async {
                    self.loading = false
                    self.game = game
                    self.checkIsFavorite()
                }
            },
            onFailure: { error in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = error
                }
            }
        )
    }
    
    func toggleFavorite() {
        guard game != nil else { return }
        
        if (game!.isFavorite == true) {
            favGameRepository.removeFavorite(gameId: self.game!.id ?? -1) {
                self.game?.isFavorite = false
            }
        } else {
            favGameRepository.addFavorite(game: self.game!) {
                self.game?.isFavorite = true
            }
        }
    }
    
    func checkIsFavorite() {
        guard game != nil else { return }
        
        favGameRepository.findData(gameId: game!.id ?? -1) { isFavorite in
            self.game?.isFavorite = isFavorite
        }
    }
}
