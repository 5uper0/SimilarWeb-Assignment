//
//  MockData.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

// Provides a set of mock data for testing and preview purposes.
struct MockData {

    // A sample photo object for testing and preview purposes.
    static let photo = Photo(
        id: "1",
        description: "Test Photo",
        urls: PhotoUrls(
            raw: "",
            full: "",
            regular: "",
            small: "small",
            thumb: ""
        ),
        user: User(
            username: "username",
            firstName: "firstname",
            lastName: "lastname",
            bio: "bio",
            profileImage: User.ProfileImage(
                small: "small",
                medium: "",
                large: ""
            )
        )
    )
}
