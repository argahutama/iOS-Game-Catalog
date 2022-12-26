//
//  FavoriteViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import Foundation
import RxSwift
import CorePackage

class FavoriteViewModel: ObservableObject {
    private let useCase: FavoriteGameUseCase
    private let disposeBag = DisposeBag()

    @Published var games = [Game]()
    @Published var error: Error?

    init(useCase: FavoriteGameUseCase) {
        self.useCase = useCase
        getFavoriteGames()
    }

    func getFavoriteGames() {
        useCase.getAllFavoriteGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result.map { entity in
                    mapGameEntityToUiModel(entity)
                }
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
