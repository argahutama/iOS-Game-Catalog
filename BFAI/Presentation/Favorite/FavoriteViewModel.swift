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
    
    private let repository = FavoriteGameRepositoryImpl()
    private let disposeBag = DisposeBag()
    
    @Published var games = [Game]()
    @Published var error: Error? = nil
    
    func getFavoriteGames() {
        repository.getAllFavoriteGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result
            } onError: { error in
                self.error = error
            } onCompleted: {}
            .disposed(by: disposeBag)
    }
    
    func removeFavorite(at index: Int) {
        repository.removeFavorite(gameId: games[index].id ?? -1)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games.remove(at: index)
            } onError: { error in
                self.error = error
            } onCompleted: {}
            .disposed(by: disposeBag)
    }
}
