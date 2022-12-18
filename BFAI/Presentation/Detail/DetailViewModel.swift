//
//  DetailViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import RxSwift

class DetailViewModel: ObservableObject {
    
    private let repository: GameDetailRepository = GameDetailRepositoryImpl()
    private let favGameRepository: FavoriteGameRepositoryImpl = FavoriteGameRepositoryImpl()
    private let disposeBag = DisposeBag()
    
    @Published var game: Game? = nil
    @Published var error: Error? = nil
    @Published var loading = true
    
    func getGameDetail(id: Int) {
        repository.getGame(id: id)
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
        
        if (game!.isFavorite == true) {
            favGameRepository.removeFavorite(gameId: self.game!.id ?? -1)
                .observe(on: MainScheduler.instance)
                .subscribe { result in
                    self.game?.isFavorite = false
                } onError: { error in
                    self.error = error
                } onCompleted: {
                    self.loading = false
                }
                .disposed(by: disposeBag)
        } else {
            favGameRepository.addFavorite(game: self.game!)
                .observe(on: MainScheduler.instance)
                .subscribe { result in
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
        
        favGameRepository.findData(gameId: game!.id ?? -1)
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
