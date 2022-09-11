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
        getGames()
    }
    
    let getGameRepository = GetGameRepository()
    
    @Published var games = [Game]()
    @Published var error: Error? = nil
    @Published var loading = false
    @Published var isLoadMore = false
    var currentPage = 1
    var enableLoadMore = false
    
    func getGames() {
        currentPage = 1
        getGameRepository.getGames(page: currentPage)
        loading = true
    }
    
    func loadMoreGames() {
        if !enableLoadMore {
            return
        }
        getGameRepository.getGames(page: currentPage + 1)
        isLoadMore = true
    }
    
    func didUpdateGames(_ repository: GetGameRepository, games: [Game], enableLoadMore: Bool) {
        DispatchQueue.main.async {
            self.loading = false
            self.games = games
            self.enableLoadMore = enableLoadMore
        }
    }
    
    func didLoadMoreGames(_ repository: GetGameRepository, games: [Game], enableLoadMore: Bool) {
        DispatchQueue.main.async {
            self.isLoadMore = false
            self.currentPage = self.currentPage + 1
            self.games = self.games + games
            self.enableLoadMore = enableLoadMore
        }
    }
    
    func didUpdateFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.loading = false
            self.error = error
        }
    }
    
    func didLoadMoreFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.isLoadMore = false
            self.error = error
        }
    }
    
    func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == games.count - 1 else { return }
        loadMoreGames()
    }
}
