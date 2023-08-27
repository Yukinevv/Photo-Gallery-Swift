//
//  CustomBackButton.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

struct CustomBackButton: View {
    var buttonTitle: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title3)
                Text(buttonTitle)
            }
        }
    }
}
