//
//  UserUseCase.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

protocol UserUseCase {
    func set(newProfile profile: Profile)
    func getProfile() -> Profile?
    func sync()
}

class UserUseCaseImpl: UserUseCase {
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func set(newProfile profile: Profile) {
        repository.set(newProfile: profile)
    }
    
    func getProfile() -> Profile? {
        return repository.getProfile()
    }
    
    func sync() {
        repository.sync()
    }
}
