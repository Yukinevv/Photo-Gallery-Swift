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
                    .frame(width: 200, height: 200)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}
