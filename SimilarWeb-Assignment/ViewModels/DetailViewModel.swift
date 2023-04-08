//
//  DetailViewModel.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation
import Combine

// Protocol defining the requirements for a DetailViewModel instance
protocol DetailViewModelProtocol {
    var photo: Photo { get }
    var username: String { get }
    var thumbURL: URL? { get }
    var bio: String? { get }
    var fullname: String { get }
}

// DetailViewModel class implementing the DetailViewModelProtocol
final class DetailViewModel: ObservableObject, DetailViewModelProtocol {
    // Published property to observe changes in the photo
    @Published var photo: Photo

    // Initializing the DetailViewModel with a photo
    init(photo: Photo) {
        self.photo = photo
    }

    var username: String {
        photo.user.username
    }

    var thumbURL: URL? {
        URL(string: photo.user.profileImage.large)
    }

    var bio: String? {
        photo.user.bio
    }

    // Computed property to get the full name of the user from the user object inside the photo object
    var fullname: String {
        [photo.user.firstName, photo.user.lastName]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
