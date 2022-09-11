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
                List(viewModel.games) { game in
                    Text(game.name ?? "")
                }.listStyle(.grouped).onAppear {
                    let tableHeaderView = UIView(frame: .zero)
                    tableHeaderView.frame.size.height = 1
                    UITableView.appearance().tableHeaderView = tableHeaderView
                }
                if viewModel.loading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationBarTitle("Game List", displayMode: .inline)
        }
    }
}
