//
//  UserRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation

protocol UserRepository {
    func set(newProfile profile: Profile)
    func getProfile() -> Profile?
    func sync()
}
