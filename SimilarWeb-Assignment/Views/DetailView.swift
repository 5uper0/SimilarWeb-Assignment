//
//  DetailView.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    struct Texts {
        static let title = "Image Details"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: viewModel.photo.imageURL)
                    .scaledToFit()
                    .padding()

                if let description = viewModel.photo.description {
                    Text(description)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }

                HStack {
                    AsyncImage(url: viewModel.thumbURL)
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.fullname)
                        Text(viewModel.username)
                        if let bio = viewModel.bio {
                            Text(bio)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(Texts.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(photo: MockData.photo))
    }
}
