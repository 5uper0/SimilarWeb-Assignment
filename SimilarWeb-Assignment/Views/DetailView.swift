//
//  DetailView.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                imageView
                descriptionView
                userView
            }
            .padding()
        }
        .navigationTitle(Texts.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension DetailView {
    // Constants used in the view
    struct Texts {
        static let title = "Image Details"
    }

    var imageView: some View {
        AsyncImage(url: viewModel.photo.imageURL)
            .scaledToFit()
    }

    var descriptionView: some View {
        Group {
            if let description = viewModel.photo.description {
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    var userView: some View {
        HStack {
            AsyncImage(url: viewModel.thumbURL)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(viewModel.fullname)
                Text(viewModel.username)
                if let bio = viewModel.bio {
                    Text(bio)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(photo: MockData.photo))
    }
}
