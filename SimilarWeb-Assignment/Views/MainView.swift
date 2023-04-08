//
//  MainView.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        // Main view
        NavigationView {
            VStack {
                // Show loading indicator while data is loading
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                } else {
                    // Show search results list
                    resultsList
                }
            }
            .navigationTitle(Texts.title)
        }
        // Add search bar to navigation view
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Texts.prompt)
        // Call search function when user hits search button
        .onSubmit(of: .search, viewModel.search)
    }
}

private extension MainView {
    // Constants used in the view
    struct Texts {
        static let title = "Home Assignment"
        static let prompt = "Search for images"
        static let noDescription = "No description"
    }

    struct Sizes {
        static let imageSize: CGFloat = 50
    }

    // Create the search results list
    var resultsList: some View {
        List(viewModel.photos) { photo in
            NavigationLink(
                destination: destination(for: photo)) {
                    HStack {
                        // Show image thumbnail
                        AsyncImage(url: photo.imageURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Sizes.imageSize, height: Sizes.imageSize)
                            .clipShape(Circle())
                        // Show photo description with truncation
                        Text(photo.description ?? Texts.noDescription)
                            .lineLimit(1)
                    }
                }
        }
    }

    // Navigate to detail view when photo is tapped
    func destination(for photo: Photo) -> some View {
        DetailView(viewModel: DetailViewModel(photo: photo))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the main view
        MainView(viewModel: MainViewModel(networkManager: NetworkManager()))
    }
}
