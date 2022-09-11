//
//  HomePage.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI
import Kingfisher

struct HomePage: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    let withIndex = viewModel.games.enumerated().map({ $0 })
                    List(withIndex, id: \.element.id) { i, game in
                        HStack {
                            KFImage.url(URL(string: game.backgroundImage ?? ""))
                                .placeholder { p in ProgressView() }
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                                .clipped()
                            VStack(alignment: .leading, spacing: 12) {
                                Text(game.name ?? "").font(.system(size: 16))
                                Text(
                                    Utils.formattedDateFromString(
                                        dateString: game.released ?? ""
                                    )
                                ).font(.system(size: 12)).foregroundColor(.gray)
                                RatingView(rating: game.rating ?? 0)
                            }.padding()
                        }.onAppear {
                            viewModel.getNextPageIfNecessary(encounteredIndex: i)
                        }
                    }.listStyle(.grouped).onAppear {
                        let tableHeaderView = UIView(frame: .zero)
                        tableHeaderView.frame.size.height = 1
                        UITableView.appearance().tableHeaderView = tableHeaderView
                    }
                }
                if viewModel.loading || viewModel.isLoadMore {
                    VStack {
                        Spacer()
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                        if (!viewModel.isLoadMore) {
                            Spacer()
                        }
                    }.frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                }
            }
            .navigationBarTitle("Game List", displayMode: .inline)
            .background(Color.gray)
        }
    }
}
