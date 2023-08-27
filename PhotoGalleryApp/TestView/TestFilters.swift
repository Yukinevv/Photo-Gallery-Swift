//
//  Filters.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 23/08/2023.
//

import Combine
import SwiftUI

struct TestFiltersView: View {
    @State var filterField: String = ""
    @Binding var images: [MyImage]
    @Binding var filteredImages: [MyImage]

    var body: some View {
        VStack {
            TextField("Szukaj obrazów", text: $filterField, onCommit: filterByName)
                .autocapitalization(.none)
                .padding()

            HStack {
                Button("Rosnąco") {
                    sortByName(ascending: true)
                }
                Button("Malejąco") {
                    sortByName(ascending: false)
                }
            }
            .padding()
        }
    }

    func filterByName() {
        if filterField.isEmpty {
            filteredImages = images
        } else {
            let filteredImages = images.filter { $0.filename.lowercased().contains(filterField.lowercased()) }
            self.filteredImages = filteredImages
        }
    }

    func sortByName(ascending: Bool) {
        filteredImages.sort { a, b in
            if ascending {
                return a.filename.localizedCaseInsensitiveCompare(b.filename) == .orderedAscending
            } else {
                return a.filename.localizedCaseInsensitiveCompare(b.filename) == .orderedDescending
            }
        }
    }
}

struct TestFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        TestFiltersView(images: .constant([]), filteredImages: .constant([]))
    }
}
