//
//  DetailViewModel.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation
import Combine

protocol DetailViewModelProtocol {
    var photo: Photo { get }
    var username: String { get }
    var thumbURL: URL? { get }
    var bio: String? { get }
    var fullname: String { get }
}

class DetailViewModel: ObservableObject {
    @Published var photo: Photo

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

    var fullname: String {
        [photo.user.firstName, photo.user.lastName]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
