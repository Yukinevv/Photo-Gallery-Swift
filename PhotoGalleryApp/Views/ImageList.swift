//
//  ImageList.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

struct ImageList: View {
    var filteredImages: [MyImage]
    var onImageClick: (MyImage) -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(filteredImages, id: \.id) { image in
                    VStack {
                        image.image
                            .resizable()
                            .frame(width: 150, height: 150)
                            .onTapGesture {
                                onImageClick(image)
                            }
                        Text(image.filename)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .padding(.init(top: 0, leading: 12, bottom: 4, trailing: 12))
    }
}
