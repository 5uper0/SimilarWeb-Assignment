//
//  User.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

// Represents a user object with relevant properties.
struct User: Codable {
    
    // Represents a collection of user profile image URLs.
    struct ProfileImage: Codable {
        let small, medium, large: String
    }

    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    let profileImage: ProfileImage

    // Coding keys for mapping JSON keys to property names.
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case username, bio
    }
}
