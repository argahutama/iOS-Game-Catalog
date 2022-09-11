//
//  DetailPage.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI
import Kingfisher

struct DetailPage: View {
    let gameId: Int
    @StateObject var viewModel = DetailViewModel()
    @State private var size: CGSize = .zero
    
    init(gameId: Int) {
        self.gameId = gameId
    }
    
    var body: some View {
        VStack {
            if !viewModel.loading {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        KFImage(URL(string: viewModel.game?.backgroundImage ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: UIScreen.main.bounds.size.width,
                                height: 250,
                                alignment: .center
                            )
                            .clipped()
                        
                        Spacer()
                        
                        Text(viewModel.game?.name ?? "")
                            .fontWeight(.heavy)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(
                                EdgeInsets(
                                    top: 10,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 20
                                )
                            )
                        
                        Text("\(Utils.formattedDateFromString(dateString: viewModel.game?.released) )")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 20
                                )
                            )
                        
                        Spacer()
                        
                        
                        Text(viewModel.game?.description?.htmlStripped ?? "")
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .padding()
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Rating")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                
                                Text(String(viewModel.game?.rating ?? 0.0))
                                
                                Text("Genre")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .padding(.top)
                                
                                ForEach(viewModel.game?.genres ?? [CommonModel]()) { genre in
                                    Text(genre.name)
                                }
                            }
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            
                            VStack(alignment: .leading) {
                                Text("Average playtime")
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                
                                Text("\(viewModel.game?.playtime ?? 0) Hours")
                            }
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    }
                }
            } else {
                Spacer()
                ProgressView().progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        }
        .onAppear {
            viewModel.getGameDetail(id: gameId)
        }
    }
}
