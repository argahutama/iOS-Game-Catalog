//
//  FavoritePage.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import SwiftUI

struct FavoritePage: View {
    @EnvironmentObject var viewModel: FavoriteViewModel

    var body: some View {
        VStack {
            let withIndex = viewModel.games.enumerated().map({ $0 })
            if !viewModel.games.isEmpty {
                List(withIndex, id: \.element.id) { index, game in
                    ItemGame(
                        game: game,
                        index: index,
                        onAppear: { _ in }
                    )
                    .swipeActions {
                        Button("Remove from Favorite") {
                            viewModel.removeFavorite(at: index)
                        }.tint(.red)
                    }
                }.listStyle(.grouped).onAppear {
                    let tableHeaderView = UIView(frame: .zero)
                    tableHeaderView.frame.size.height = 1
                    UITableView.appearance().tableHeaderView = tableHeaderView
                }
            } else {
                Spacer()
                Text("No Favorite Game Found!")
                Spacer()
            }
        }
        .navigationBarTitle("Favorite Games", displayMode: .inline)
        .background(.white)
        .onAppear {
            viewModel.getFavoriteGames()
        }
    }
}
