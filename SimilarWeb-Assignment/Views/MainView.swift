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
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                } else {
                    resultsList
                }
            }
            .navigationTitle(Texts.title)
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Texts.prompt)
        .onSubmit(of: .search, viewModel.search)
    }
}

private extension MainView {
    struct Texts {
        static let title = "Home Assignment"
        static let prompt = "Search for images"
        static let noDescription = "No description"
    }

    struct Sizes {
        static let imageSize: CGFloat = 50
    }

    var resultsList: some View {
        List(viewModel.photos) { photo in
            NavigationLink(
                destination: destination(for: photo)) {
                HStack {
                    AsyncImage(url: photo.imageURL)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Sizes.imageSize, height: Sizes.imageSize)
                        .clipShape(Circle())
                    Text(photo.description ?? Texts.noDescription)
                        .lineLimit(1)
                }
            }
        }
    }

    func destination(for photo: Photo) -> some View {
        DetailView(viewModel: DetailViewModel(photo: photo))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(networkManager: NetworkManager()))
    }
}
