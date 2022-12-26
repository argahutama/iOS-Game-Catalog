//
//  ProfileUiMapper.swift
//  BFAI
//
//  Created by Arga Hutama on 21/12/22.
//

import Foundation
import CorePackage

func mapProfileEntityToUiModel(_ entity: ProfileEntity) -> Profile {
    return Profile(
        name: entity.name,
        profilePicture: entity.profilePicture,
        city: entity.city,
        workingAt: entity.workingAt,
        position: entity.position
    )
}

func mapProfileUiModelToEntity(_ profile: Profile) -> ProfileEntity {
    return ProfileEntity(
        name: profile.name,
        profilePicture: profile.profilePicture,
        city: profile.city,
        workingAt: profile.workingAt,
        position: profile.position
    )
}
