//
//  FavoriteViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import Foundation
import RxSwift

class FavoriteViewModel: ObservableObject {
    init() {
        getFavoriteGames()
    }

    private let useCase = Injection.sharedInstance.provideFavoriteGameUseCase()
    private let disposeBag = DisposeBag()

    @Published var games = [GameEntity]()
    @Published var error: Error?

    func getFavoriteGames() {
        useCase.getAllFavoriteGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result
            } onError: { error in
                self.error = error
            } onCompleted: {}
            .disposed(by: disposeBag)
    }

    func removeFavorite(at index: Int) {
        useCase.removeFavorite(gameId: games[index].id)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.games.remove(at: index)
            } onError: { error in
                self.error = error
            } onCompleted: {}
            .disposed(by: disposeBag)
    }
}
