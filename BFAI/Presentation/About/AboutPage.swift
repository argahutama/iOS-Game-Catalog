//
//  AboutPage.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI
import Kingfisher

struct AboutPage: View {
    @EnvironmentObject var viewModel: AboutViewModel

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: viewModel.myProfile.profilePicture ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: UIScreen.main.bounds.size.width,
                            height: 250,
                            alignment: .center
                        )
                        .clipped()

                    Spacer()

                    Text(viewModel.myProfile.name)
                        .fontWeight(.heavy)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(
                            EdgeInsets(
                                top: 5,
                                leading: 20,
                                bottom: 0,
                                trailing: 20
                            )
                        )

                    Text("\(viewModel.myProfile.position ?? "") @\(viewModel.myProfile.workingAt ?? "")")
                        .padding(
                            EdgeInsets(
                                top: 5,
                                leading: 20,
                                bottom: 0,
                                trailing: 20
                            )
                        )

                    Text(viewModel.myProfile.city ?? "")
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 20,
                                bottom: 0,
                                trailing: 20
                            )
                        )
                }
            }
        }
        .navigationBarTitle("About Me", displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack {
                    NavigationLink(destination: EditProfilePage()) {
                        Text("Edit Profile")
                    }
                }
        )
        .onAppear {
            viewModel.getProfile()
        }
    }
}
