//
//  Image.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 19/08/2023.
//

import SwiftUI

struct MyImage: Identifiable {
    var id: String
    var filename: String
    var imageUrl: URL?
    var image: Image
}
