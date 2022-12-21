//
//  ItemGame.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import SwiftUI
import Kingfisher

struct ItemGame: View {
    let game: Game
    let index: Int
    let onAppear: (Int) -> Void

    var body: some View {
        NavigationLink(destination: DetailPage(gameId: game.id)) {
            HStack {
                KFImage.url(URL(string: game.backgroundImage))
                    .placeholder { _ in ProgressView() }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    .clipped()
                VStack(alignment: .leading, spacing: 12) {
                    Text(game.name)
                        .font(.system(size: 16))
                        .frame(
                            minWidth: 100,
                            alignment: .leading
                        )

                    Text(
                        Utils.formattedDateFromString(
                            dateString: game.released
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
                onAppear(index)
            }
        }
    }
}
