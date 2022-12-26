//
//  UserUseCase.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

public protocol UserUseCase {
    func set(newProfile profile: ProfileEntity)
    func getProfile() -> ProfileEntity
    func sync()
}

class UserUseCaseImpl: UserUseCase {

    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func set(newProfile profile: ProfileEntity) {
        repository.set(newProfile: profile)
    }

    func getProfile() -> ProfileEntity {
        return repository.getProfile()
    }

    func sync() {
        repository.sync()
    }
}
