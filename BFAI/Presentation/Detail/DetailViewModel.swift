//
//  DetailViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class DetailViewModel: ObservableObject, GetGameDetailDelegate {
    
    let repository = GetGameDetailRepository()
    let favGameProvider = FavoriteGameProvider()
    
    @Published var game: Game? = nil
    @Published var error: Error? = nil
    @Published var loading = true
    
    init() {
        repository.delegate = self
    }
    
    func getGameDetail(id: Int) {
        repository.getGame(id: id)
    }
    
    func didUpdateGame(_ repository: GetGameDetailRepository, game: Game?) {
        DispatchQueue.main.async {
            self.loading = false
            self.game = game
            self.checkIsFavorite()
        }
    }
    
    func didUpdateFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.loading = false
            self.error = error
        }
    }
    
    func toggleFavorite() {
        guard game != nil else { return }
        
        if (game!.isFavorite == true) {
            favGameProvider.removeFavorite(gameId: self.game!.id ?? -1) {
                self.game?.isFavorite = false
            }
        } else {
            favGameProvider.addFavorite(game: self.game!) {
                self.game?.isFavorite = true
            }
        }
    }
    
    func checkIsFavorite() {
        guard game != nil else { return }
        
        favGameProvider.findData(gameId: game!.id ?? -1) { isFavorite in
            self.game?.isFavorite = isFavorite
        }
    }
}
