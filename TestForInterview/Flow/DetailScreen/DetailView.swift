//
//  DetailView.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    @State var isFavorite: Bool = true
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                PosterImageView(imageURL: viewModel.detailModelModel?.fullPosterURL)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 250, height: 377)
                
                Text("Rating: \(String(format: "%.1f", viewModel.detailModelModel?.voteAverage ?? 0.0))")
                    .font(.system(size: 10))
                    .padding(.top, 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        Text(viewModel.detailModelModel?.overview ?? "")
                            .font(.system(size: 12))
                            .padding(.top, 16)
                    }
                    .frame(maxHeight: 100)
                    
                    Text(viewModel.detailModelModel?.releaseDate ?? "")
                        .font(.system(size: 12))
                        .padding(.top, 16)
                }
            }
            .padding(.top, 24)
            
            Button {
                self.viewModel.onLoad()
            } label: { Text("Add to favorites") }
            .dynamicButtonStyle(isFavorite: isFavorite)
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(viewModel.detailModelModel?.title ?? "Movie")
        .onAppear() {
            self.viewModel.onLoad()
        }
    }
 
}

#Preview {
    DetailView(viewModel: DetailViewModel(movieId: 120))
}
