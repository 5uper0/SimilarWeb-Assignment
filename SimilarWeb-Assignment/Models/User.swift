//
//  User.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

struct User: Codable {
    struct ProfileImage: Codable {
        let small, medium, large: String
    }

    let username, firstName, bio: String
    let lastName: String?
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case username, bio
    }
}
