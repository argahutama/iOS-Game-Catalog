//
//  DetailViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import RxSwift

class DetailViewModel: ObservableObject {

    private let gameDetailUseCase: GameDetailUseCase = Injection.sharedInstance.provideGameDetailUseCase()
    private let favGameUseCase: FavoriteGameUseCase = Injection.sharedInstance.provideFavoriteGameUseCase()
    private let disposeBag = DisposeBag()

    @Published var game: GameEntity?
    @Published var error: Error?
    @Published var loading = true

    func getGameDetail(id: Int) {
        gameDetailUseCase.getGame(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.game = result
                self.checkIsFavorite()
            } onError: { error in
                self.error = error
            } onCompleted: {
                self.loading = false
            }
            .disposed(by: disposeBag)
    }

    func toggleFavorite() {
        guard game != nil else { return }

        if game!.isFavorite == true {
            favGameUseCase.removeFavorite(gameId: self.game!.id)
                .observe(on: MainScheduler.instance)
                .subscribe { _ in
                    self.game?.isFavorite = false
                } onError: { error in
                    self.error = error
                } onCompleted: {
                    self.loading = false
                }
                .disposed(by: disposeBag)
        } else {
            favGameUseCase.addFavorite(game: self.game!)
                .observe(on: MainScheduler.instance)
                .subscribe { _ in
                    self.game?.isFavorite = true
                } onError: { error in
                    self.error = error
                } onCompleted: {
                    self.loading = false
                }
                .disposed(by: disposeBag)
        }
    }

    func checkIsFavorite() {
        guard game != nil else { return }

        favGameUseCase.findData(gameId: game!.id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.game?.isFavorite = result
            } onError: { error in
                self.error = error
            } onCompleted: {
                self.loading = false
            }
            .disposed(by: disposeBag)
    }
}
