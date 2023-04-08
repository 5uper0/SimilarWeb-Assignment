//
//  MainViewModel.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import SwiftUI
import Combine

protocol MainViewModelProtocol {
    func search()
}

class MainViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private let networkManager: NetworkManager
    private var cancellables = Set<AnyCancellable>()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension MainViewModel: MainViewModelProtocol {
    func search() {
        isLoading = true
        networkManager.searchPhotos(query: searchText) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let photos):
                    self?.photos = photos
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error, e.g., show an alert
                }
            }
        }
    }
}
