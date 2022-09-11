//
//  DetailViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class DetailViewModel: ObservableObject, GetGameDetailDelegate {
    
    let repository = GetGameDetailRepository()
    
    @Published var game: Game? = nil
    @Published var error: Error? = nil
    @Published var loading = true
    
    init() {
        repository.delegate = self
    }
    
    func getGameDetail(id: Int) {
        repository.getGame(id: id)
    }
    
    func didUpdateGame(_ repository: GetGameDetailRepository, game: Game?) {
        DispatchQueue.main.async {
            self.loading = false
            self.game = game
        }
    }
    
    func didUpdateFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.loading = false
            self.error = error
        }
    }
}
