//
//  MainView.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    private let imageSize: CGFloat = 50

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
            .navigationTitle("Home Assignment")
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search for images")
        .onSubmit(of: .search, viewModel.search)
    }
}

private extension MainView {

    var resultsList: some View {
        List(viewModel.photos) { photo in
            NavigationLink(destination: Text("Detail View")) {
                HStack {
                    AsyncImage(url: photo.smallPhotoURL)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(Circle())
                    Text(photo.description ?? "No description")
                }
            }
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(networkManager: NetworkManager()))
    }
}
