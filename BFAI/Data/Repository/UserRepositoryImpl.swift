//
//  UserRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import Foundation

class UserRepositoryImpl: UserRepository {
    func set(newProfile profile: Profile) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: "profile")
        }
    }
    
    func getProfile() -> Profile? {
        if let data = UserDefaults.standard.object(forKey: "profile") as? Data,let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            return profile
        }
        return nil
    }
    
    func sync() {
        UserDefaults.standard.synchronize()
    }
}
