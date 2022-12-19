//
//  EditProfileViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    private let useCase: UserUseCase = Injection.sharedInstance.provideUserUseCase()

    @Published var myProfile = ProfileEntity(name: "")

    init() {
        self.myProfile = useCase.getProfile()
    }

    func setNewProfile() {
        useCase.set(newProfile: myProfile)
    }
}
