//
//  AboutViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation
import CorePackage

class AboutViewModel: ObservableObject {
    private let useCase: UserUseCase
    @Published var myProfile = Profile(name: "")

    init(useCase: UserUseCase) {
        self.useCase = useCase
        getProfile()
    }

    func getProfile() {
        myProfile = mapProfileEntityToUiModel(useCase.getProfile())
    }
}
