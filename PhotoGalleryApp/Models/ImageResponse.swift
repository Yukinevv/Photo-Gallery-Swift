//
//  ImageResponse.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 19/08/2023.
//

import Foundation

struct ImageResponse: Decodable {
    var id: String
    var filename: String
    var data: String
    var login: String
    var category: String
}
