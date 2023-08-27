//
//  CategoryListView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 19/08/2023.
//

import SwiftUI

struct CategoryListView: View {
    let categories = ["Krajobraz", "Zwierzęta", "Sport", "Gry", "Inne"]

    var userLogin: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Wybierz kategorie obrazów")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(categories, id: \.self) { category in
                    NavigationLink(destination: ImageListView(userLogin: userLogin, category: category)) {
                        Text(category)
                            .font(.title)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
