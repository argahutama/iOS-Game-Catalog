//
//  EditProfilePage.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import SwiftUI

struct EditProfilePage: View {
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name")
            TextField("Name", text: $viewModel.myProfile.name)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .stroke(.gray, lineWidth: 1.0))
                .onChange(of: viewModel.myProfile.name) { newValue in
                    self.viewModel.setNewProfile()
                }
                .padding(.bottom, 12)
            
            Text("City")
            TextField("City", text: $viewModel.myProfile.city.toUnwrapped(defaultValue: ""))
                .padding()
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .stroke(.gray, lineWidth: 1.0))
                .onChange(of: viewModel.myProfile.city ?? "") { newValue in
                    self.viewModel.setNewProfile()
                }
                .padding(.bottom, 12)
            
            Text("Working At")
            TextField("Working At", text: $viewModel.myProfile.workingAt.toUnwrapped(defaultValue: ""))
                .padding()
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .stroke(.gray, lineWidth: 1.0))
                .onChange(of: viewModel.myProfile.workingAt ?? "") { newValue in
                    self.viewModel.setNewProfile()
                }
                .padding(.bottom, 12)
            
            Text("Position")
            TextField("Position", text: $viewModel.myProfile.position.toUnwrapped(defaultValue: ""))
                .padding()
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .stroke(.gray, lineWidth: 1.0))
                .onChange(of: viewModel.myProfile.position ?? "") { newValue in
                    self.viewModel.setNewProfile()
                }
                .padding(.bottom, 12)
            
            Spacer()
        }.padding().navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}
