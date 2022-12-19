//
//  AboutViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class AboutViewModel: ObservableObject {
    private let useCase = Injection.sharedInstance.provideUserUseCase()
    
    @Published var myProfile = Profile()
    
    init() {
        getProfile()
    }
    
    func getProfile() {
        if let profile = useCase.getProfile() {
            self.myProfile = profile
        }
    }
}
