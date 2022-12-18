//
//  HomeViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    init() {
        getGames()
    }
    
    let getGamesRepository = GamesRepositoryImpl()
    
    @Published var games = [Game]()
    @Published var error: Error? = nil
    @Published var loading = false
    @Published var isLoadMore = false
    
    var currentPage = 1
    var enableLoadMore = false
    var keyword = ""
    
    func getGames() {
        currentPage = 1
        getGamesRepository.getGames(
            page: currentPage,
            keyword: self.keyword,
            onSuccess: { games, enableLoadMore in
                DispatchQueue.main.async {
                    self.loading = false
                    self.games = games
                    self.enableLoadMore = enableLoadMore
                }
            },
            onFailure: { error in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = error
                }
            }
        )
        loading = true
    }
    
    func loadMoreGames() {
        if !enableLoadMore {
            return
        }
        getGamesRepository.getGames(
            page: currentPage + 1,
            keyword: self.keyword,
            onSuccess: { games, enableLoadMore in
                DispatchQueue.main.async {
                    self.isLoadMore = false
                    self.currentPage = self.currentPage + 1
                    self.games.append(contentsOf: games)
                    self.enableLoadMore = enableLoadMore
                }
            },
            onFailure: { error in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = error
                }
            }
        )
        isLoadMore = true
    }
    
    func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == games.count - 1 else { return }
        loadMoreGames()
    }
}
