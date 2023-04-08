//
//  Photo.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

struct Photo: Codable, Identifiable {
    let id: String
    let description: String?
    let urls: [String: String]
    let user: User

    var imageURL: URL? {
        guard let urlString = urls["small"] else {
            return nil
        }
        return URL(string: urlString)
    }
}
