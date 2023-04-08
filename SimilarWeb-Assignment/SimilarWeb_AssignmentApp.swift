//
//  SimilarWeb_AssignmentApp.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import SwiftUI

@main
struct SimilarWeb_AssignmentApp: App {
    let networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(networkManager: networkManager))
        }
    }
}
