//
//  UserRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation

protocol UserRepository {
    func set(newProfile profile: ProfileEntity)
    func getProfile() -> ProfileEntity
    func sync()
}
