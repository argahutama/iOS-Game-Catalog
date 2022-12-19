//
//  AboutViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class AboutViewModel: ObservableObject {
    private let useCase = Injection.sharedInstance.provideUserUseCase()

    @Published var myProfile = ProfileEntity(name: "")

    init() {
        getProfile()
    }

    func getProfile() {
        self.myProfile = useCase.getProfile()
    }
}
