//
//  AboutViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

class AboutViewModel: ObservableObject {
    let repository = UserRepository()
    @Published var myProfile = Profile()
    
    init() {
        getProfile()
    }
    
    func getProfile() {
        if let profile = repository.getProfile() {
            self.myProfile = profile
        }
    }
}