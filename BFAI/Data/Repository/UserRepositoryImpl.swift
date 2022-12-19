//
//  UserRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let localDataSource: LocalDataSource

    private init(localDataSource: LocalDataSource) {
        self.localDataSource = localDataSource
    }

    static let sharedInstance: (LocalDataSource) -> UserRepository = { localDataSource in
        return UserRepositoryImpl(localDataSource: localDataSource)
    }

    func set(newProfile profile: ProfileEntity) {
        localDataSource.set(newProfile: mapProfileEntityToDto(profile))
    }

    func getProfile() -> ProfileEntity {
        return mapProfileDtoToEntity(localDataSource.getProfile())
    }

    func sync() {
        localDataSource.sync()
    }
}
