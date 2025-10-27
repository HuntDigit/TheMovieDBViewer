//
//  PosterImageView.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct PosterImageView: View {
    let imageURL: URL?
    
    var body: some View {
        VStack {
            if let url = imageURL {
                WebImage(url: url)
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
            } else {
                Rectangle().foregroundColor(.gray)
            }
        }
        
    }
}
