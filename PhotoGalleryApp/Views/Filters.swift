//
//  Filters.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 26/08/2023.
//

import SwiftUI

struct FiltersView: View {
    var userLogin: String = ""
    var category: String = ""

    @Binding var filterField: String
    var sortByName: (Bool) -> Void
    var loadImages: () -> Void

    @State var isSheetPresented: Bool = false

    var body: some View {
        VStack {
            TextField("Szukaj obrazów", text: $filterField)
                .autocapitalization(.none)
                .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))

            HStack {
                HStack {
                    Text("Sortuj:")
                    Button(action: {
                        sortByName(true)
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        sortByName(false)
                    }) {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                    }
                }

                Spacer()

                Button(action: {
                    isSheetPresented = true
                }) {
                    Text("Dodaj obraz")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isSheetPresented) {
                    FileUploadView(userLogin: userLogin, category: category, isSheetPresented: $isSheetPresented, loadImages: loadImages)
                }
            }
            .padding()
        }
    }
}
