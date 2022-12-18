//
//  HomeViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import RxSwift

class HomeViewModel: ObservableObject {
    
    init() {
        getGames()
    }
    
    private let getGamesRepository = GamesRepositoryImpl()
    private let disposeBag = DisposeBag()
    
    @Published var games = [Game]()
    @Published var error: Error? = nil
    @Published var loading = false
    @Published var isLoadMore = false
    
    var currentPage = 1
    var enableLoadMore = false
    var keyword = ""
    
    func getGames() {
        currentPage = 1
        loading = true
        getGamesRepository.getGames(page: currentPage, keyword: self.keyword)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result.results ?? []
                self.enableLoadMore = !(result.next ?? "").isEmpty
            } onError: { error in
                self.error = error
            } onCompleted: {
                self.loading = false
            }
            .disposed(by: disposeBag)
    }
    
    func loadMoreGames() {
        if !enableLoadMore {
            return
        }
        isLoadMore = true
        getGamesRepository.getGames(page: currentPage + 1, keyword: self.keyword)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.currentPage = self.currentPage + 1
                self.games.append(contentsOf: result.results ?? [])
                self.enableLoadMore = !(result.next ?? "").isEmpty
            } onError: { error in
                self.error = error
            } onCompleted: {
                self.isLoadMore = false
            }
            .disposed(by: disposeBag)
    }
    
    func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == games.count - 1 else { return }
        loadMoreGames()
    }
}
