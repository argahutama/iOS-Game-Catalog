//
//  FavoritePage.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import SwiftUI
import Kingfisher

struct FavoritePage: View {
    @StateObject var viewModel = FavoriteViewModel()
    
    var body: some View {
        VStack {
            let withIndex = viewModel.games.enumerated().map({ $0 })
            if (!viewModel.games.isEmpty) {
                List(withIndex, id: \.element.id) { i, game in
                    NavigationLink(destination: DetailPage(gameId: game.id)) {
                        HStack {
                            KFImage.url(URL(string: game.backgroundImage ?? ""))
                                .placeholder { p in ProgressView() }
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                                .clipped()
                            VStack(alignment: .leading, spacing: 12) {
                                Text(game.name).font(.system(size: 16))
                                
                                Text(
                                    Utils.formattedDateFromString(
                                        dateString: game.released ?? ""
                                    )
                                )
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .frame(
                                    minWidth: 100,
                                    alignment: .leading
                                )
                                
                                RatingView(rating: game.rating ?? 0)
                            }.padding()
                        }
                    }
                    .swipeActions {
                        Button("Remove from Favorite") {
                            viewModel.removeFavorite(at: i)
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
