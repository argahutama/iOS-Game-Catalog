//
//  EditProfileViewModel.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    private let repository: UserRepository = UserRepositoryImpl()
    
    @Published var myProfile = Profile()
    
    init() {
        if let profile = repository.getProfile() {
            self.myProfile = profile
        }
    }
    
    func setNewProfile() {
        repository.set(newProfile: myProfile)
    }
}
