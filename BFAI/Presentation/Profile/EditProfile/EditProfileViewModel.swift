//
//  EditProfileViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import Foundation

class EditProfileViewModel: ObservableObject {

    private let useCase: UserUseCase
    @Published var myProfile = Profile(name: "")

    init(useCase: UserUseCase) {
        self.useCase = useCase
        self.myProfile = mapProfileEntityToUiModel(useCase.getProfile())
    }

    func setNewProfile() {
        useCase.set(newProfile: mapProfileUiModelToEntity(myProfile))
    }
}
