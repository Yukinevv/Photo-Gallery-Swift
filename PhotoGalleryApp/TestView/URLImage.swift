//
//  URLImage.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 21/08/2023.
//

import SwiftUI

struct URLImageView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200) // Set the desired image size
            case .failure:
                Image(systemName: "photo") // Placeholder image if the download fails
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            case .empty:
                ProgressView() // Placeholder while the image is loading
            @unknown default:
                EmptyView()
            }
        }
    }
}
