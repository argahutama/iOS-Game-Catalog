//
//  Profile.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

struct ProfileDto: Codable {
    var name: String? = "Arga Hutama"
    var profilePicture: String? = "https://avatars.githubusercontent.com/u/58361416?v=4"
    var city: String? = "Surakarta"
    var workingAt: String? = "Zenius Education"
    var position: String? = "Android Engineer"
}
