//
//  AboutViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class AboutViewModel: ObservableObject {
    private let useCase: UserUseCase
    @Published var myProfile = ProfileEntity(name: "")

    init(useCase: UserUseCase) {
        self.useCase = useCase
        getProfile()
    }

    func getProfile() {
        myProfile = useCase.getProfile()
    }
}
