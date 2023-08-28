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
                Text("Wybierz kategorię")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))

                ForEach(categories, id: \.self) { category in
                    let (imageName, categoryColor) = iconForCategory(category)

                    NavigationLink(destination: ImageListView(userLogin: userLogin, category: category)) {
                        HStack {
                            Text(category)
                                .font(.title)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: imageName)
                                .font(.title)
                                .foregroundColor(categoryColor)
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray.opacity(0.4))
                                .offset(y: 30)
                        )
                        .padding()
                    }
                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }

    func iconForCategory(_ category: String) -> (String, Color) {
        switch category {
        case "Krajobraz":
            return ("square.grid.2x2.fill", Color.blue)
        case "Zwierzęta":
            return ("tortoise.fill", Color.green)
        case "Sport":
            return ("sportscourt.fill", Color.red)
        case "Gry":
            return ("gamecontroller.fill", Color.orange)
        case "Inne":
            return ("ellipsis.circle.fill", Color.purple)
        default:
            return ("questionmark.circle.fill", Color.gray)
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
