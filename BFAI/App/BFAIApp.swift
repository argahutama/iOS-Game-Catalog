//
//  BFAIApp.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI

@main
struct BFAIApp: App {
    let homeViewModel = HomeViewModel(useCase: Injection.sharedInstance.provideGamesUseCase())
    let detailViewModel = DetailViewModel(
        gameDetailUseCase: Injection.sharedInstance.provideGameDetailUseCase(),
        favGameUseCase: Injection.sharedInstance.provideFavoriteGameUseCase()
    )
    let favoriteViewModel = FavoriteViewModel(useCase: Injection.sharedInstance.provideFavoriteGameUseCase())
    let aboutViewModel = AboutViewModel(useCase: Injection.sharedInstance.provideUserUseCase())
    let editProfileViewModel = EditProfileViewModel(useCase: Injection.sharedInstance.provideUserUseCase())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
                .environmentObject(detailViewModel)
                .environmentObject(favoriteViewModel)
                .environmentObject(aboutViewModel)
                .environmentObject(editProfileViewModel)
        }
    }
}
