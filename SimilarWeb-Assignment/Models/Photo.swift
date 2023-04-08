//
//  Photo.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

struct Photo: Codable {
    let id: String
    let description: String?
    let urls: [String: String]
}
