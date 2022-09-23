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
    @State private var searchText = ""
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    let withIndex = viewModel.games.enumerated().map({ $0 })
                    List(withIndex, id: \.element.id) { i, game in
                        NavigationLink(destination: DetailPage(gameId: game.id ?? 0)) {
                            HStack {
                                KFImage.url(URL(string: game.backgroundImage ?? ""))
                                    .placeholder { p in ProgressView() }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                                    .clipped()
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(game.name ?? "")
                                        .font(.system(size: 16))
                                        .frame(
                                            minWidth: 100,
                                            alignment: .leading
                                        )
                                    
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
                            }.onAppear {
                                viewModel.getNextPageIfNecessary(encounteredIndex: i)
                            }
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
            .navigationBarTitle("Games", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    HStack {
                        NavigationLink(destination: FavoritePage()) {
                            Text("Favorites")
                        }
                        NavigationLink(destination: AboutPage()) {
                            Text("About")
                        }
                    }
            )
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.keyword = searchText.lowercased()
                viewModel.getGames()
            }
            .onChange(of: searchText) { value in
                if searchText.isEmpty && !isSearching {
                    viewModel.keyword = ""
                    viewModel.getGames()
                }
            }
            .background(.gray)
        }
    }
}
