//
//  ProfileEntity.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

public struct ProfileEntity {
    public init(
        name: String,
        profilePicture: String? = nil,
        city: String? = nil,
        workingAt: String? = nil,
        position: String? = nil
    ) {
        self.name = name
        self.profilePicture = profilePicture
        self.city = city
        self.workingAt = workingAt
        self.position = position
    }

    public var name: String
    public var profilePicture: String?
    public var city: String?
    public var workingAt: String?
    public var position: String?
}
