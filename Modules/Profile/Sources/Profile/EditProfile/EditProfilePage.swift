//
//  EditProfilePage.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import SwiftUI
import CorePackage

struct EditProfilePage: View {
    @EnvironmentObject var viewModel: EditProfileViewModel

    var body: some View {
        VStack(alignment: .leading) {
            BaseField(
                title: "Name",
                placeholder: "Name",
                text: $viewModel.myProfile.name,
                onChange: { _ in
                    self.viewModel.setNewProfile()
                }
            )
            BaseField(
                title: "City",
                placeholder: "City",
                text: $viewModel.myProfile.city.toUnwrapped(defaultValue: ""),
                onChange: { _ in
                    self.viewModel.setNewProfile()
                }
            )
            BaseField(
                title: "Working At",
                placeholder: "Working At",
                text: $viewModel.myProfile.workingAt.toUnwrapped(defaultValue: ""),
                onChange: { _ in
                    self.viewModel.setNewProfile()
                }
            )
            BaseField(
                title: "Position",
                placeholder: "Position",
                text: $viewModel.myProfile.position.toUnwrapped(defaultValue: ""),
                onChange: { _ in
                    self.viewModel.setNewProfile()
                }
            )
            Spacer()
        }.padding().navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}
