import SwiftUI
import Combine

// Protocol defining the search method
protocol MainViewModelProtocol {
    func search()
}

// Main view model class
class MainViewModel: ObservableObject {
    // Published properties
    @Published var photos: [Photo] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    // Private properties
    private let networkManager: NetworkManager
    private var cancellables = Set<AnyCancellable>()

    // Initializer
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

// Conform to the search method protocol
extension MainViewModel: MainViewModelProtocol {
    // Search method implementation
    func search() {
        // Set loading flag to true
        isLoading = true

        // Call the network manager to search photos
        networkManager.searchPhotos(query: searchText) { [weak self] result in
            DispatchQueue.main.async {
                // Set loading flag to false
                self?.isLoading = false

                switch result {
                case .success(let photos):
                    // Update photos array with the search results
                    self?.photos = photos
                case .failure(let error):
                    // Print error for now
                    print("Error: \(error)")
                    // Handle the error, e.g., show an alert
                }
            }
        }
    }
}
