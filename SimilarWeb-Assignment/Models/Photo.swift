//
//  Photo.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

// Represents a photo object with its relevant properties.
struct Photo: Codable, Identifiable, Equatable {
    let id: String
    let description: String?
    let urls: PhotoUrls
    let user: User

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }

    // Computes a URL for the small size of the photo.
    var imageURL: URL? {
        return URL(string: urls.small)
    }
}

// Represents a collection of photo URLs in different sizes.
struct PhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

// Resresents a collection of photo objects
struct PhotoResponse: Codable {
    let results: [Photo]
}
