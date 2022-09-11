//
//  HomePage.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI

struct HomePage: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    let withIndex = viewModel.games.enumerated().map({ $0 })
                    List(withIndex, id: \.element.name) { i, game in
                        Text(game.name ?? "").onAppear {
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
        }
    }
}
