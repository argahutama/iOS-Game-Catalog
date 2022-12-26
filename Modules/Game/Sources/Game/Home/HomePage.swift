//
//  HomePage.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI

public struct HomePage<Destination: View>: View {
    let onAboutClicked: () -> Destination
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var searchText = ""
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch

    public init(onAboutClicked: @escaping (() -> Destination)) {
        self.onAboutClicked = onAboutClicked
    }

    public var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    let withIndex = viewModel.games.enumerated().map({ $0 })
                    List(withIndex, id: \.element.id) { index, game in
                        ItemGame(
                            game: game,
                            index: index,
                            onAppear: { index in
                                viewModel.getNextPageIfNecessary(encounteredIndex: index)
                            }
                        )
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
                        if !viewModel.isLoadMore {
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
                        NavigationLink(destination: self.onAboutClicked()) {
                            Text("About")
                        }
                    }
            )
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.keyword = searchText.lowercased()
                viewModel.getGames()
            }
            .onChange(of: searchText) { _ in
                if searchText.isEmpty && !isSearching {
                    viewModel.keyword = ""
                    viewModel.getGames()
                }
            }
            .background(.gray)
        }
    }
}
