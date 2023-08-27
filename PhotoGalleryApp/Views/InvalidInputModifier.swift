//
//  InvalidInputModifier.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

struct InvalidInputModifier: ViewModifier {
    @Binding var isInvalid: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: isInvalid ? 2 : 0)
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            )
    }
}

struct InvalidInputModifier2: ViewModifier {
    @Binding var isInvalid: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: isInvalid ? 2 : 0)
            )
    }
}
