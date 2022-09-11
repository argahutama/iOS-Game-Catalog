//
//  HomeViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class HomeViewModel: ObservableObject, GetGamesDelegate {
    init() {
        getGameRepository.delegate = self
        updateGames()
    }
    
    let getGameRepository = GetGameRepository()
    
    @Published var games = [Game]()
    @Published var error: Error? = nil
    @Published var loading = false
    
    func updateGames(page: Int = 1) {
        getGameRepository.getGames(page: page)
        loading = true
    }
    
    func didUpdateGamess(_ repository: GetGameRepository, games: [Game]) {
        DispatchQueue.main.async {
            self.loading = false
            self.games = games
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.loading = false
            self.error = error
        }
    }
}
