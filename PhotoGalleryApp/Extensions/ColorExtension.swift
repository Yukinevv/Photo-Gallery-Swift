//
//  ColorExtension.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

extension Color {
    init(hex: UInt32, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }

    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: 1
        )
    }

    init(rgb: UInt8, green: UInt8, blue: UInt8) {
        self.init(
            .sRGB,
            red: Double(rgb) / 255.0,
            green: Double(green) / 255.0,
            blue: Double(blue) / 255.0,
            opacity: 1
        )
    }
}
