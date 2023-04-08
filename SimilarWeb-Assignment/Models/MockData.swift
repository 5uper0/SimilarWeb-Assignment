//
//  MockData.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

struct MockData {
    static let photo = Photo(
        id: "1",
        description: "Test Photo",
        urls: [:],
        user:
            User(
                username: "username",
                firstName: "firstname",
                bio: "bio",
                lastName: "lastname",
                profileImage:
                    User.ProfileImage(
                        small: "small",
                        medium: "",
                        large: "")
            )
    )
}
