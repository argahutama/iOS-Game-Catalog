//
//  HomeViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import RxSwift

class HomeViewModel: ObservableObject {

    private let useCase: GamesUseCase
    private let disposeBag = DisposeBag()

    @Published var games = [GameEntity]()
    @Published var error: Error?
    @Published var loading = false
    @Published var isLoadMore = false

    var currentPage = 1
    var enableLoadMore = false
    var keyword = ""

    init(useCase: GamesUseCase) {
        self.useCase = useCase
        getGames()
    }

    func getGames() {
        currentPage = 1
        loading = true
        useCase.getGames(page: currentPage, keyword: self.keyword)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result.items
                self.enableLoadMore = result.isEnableLoadMore()
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
        useCase.getGames(page: currentPage + 1, keyword: self.keyword)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.currentPage += 1
                self.games.append(contentsOf: result.items)
                self.enableLoadMore = result.isEnableLoadMore()
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
