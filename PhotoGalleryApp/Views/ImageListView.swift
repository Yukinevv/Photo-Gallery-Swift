//
//  ImageListView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 21/08/2023.
//

import Alamofire
import Combine
import SwiftUI

struct ImageListView: View {
    @State private var images: [MyImage] = []
    @State private var selectedImage: MyImage? = nil

    // @State private var filteredImages: [MyImage] = []
    @State private var filterField: String = ""

    var userLogin: String = ""
    @State var category: String = ""

    @State private var cancellables: [AnyCancellable] = []

    var body: some View {
        VStack {
            FiltersView(userLogin: userLogin, category: category, filteredImagesCount: getFilteredImages.count, filterField: $filterField, sortByName: sortByName, loadImages: loadImages)

            if images.isEmpty {
                Text("Nie wstawiono jeszcze żadnego obrazu...")
                    .font(.headline)
                    .padding()
            } else {
                ImageList(filteredImages: getFilteredImages, onImageClick: { image in
                    selectedImage = image
                })
            }

            Spacer()
        }
        .onAppear {
            // userLogin = UserDefaults.standard.string(forKey: "userLogin") ?? "jank1"
            // category = UserDefaults.standard.string(forKey: "category") ?? "Sport"
            // fetchImages()
            loadImages()
            // filteredImages = images
        }
        .sheet(item: $selectedImage) { image in
            SelectedImagePopupView(selectedImage: image, loadImages: loadImages) {
                selectedImage = nil
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(buttonTitle: "Kategorie"))
    }

    var getFilteredImages: [MyImage] {
        if filterField.isEmpty {
            return images
        } else {
            return images.filter { $0.filename.lowercased().contains(filterField.lowercased()) }
        }
    }

    func sortByName(ascending: Bool) {
        images.sort { a, b in
            if ascending {
                return a.filename.localizedCaseInsensitiveCompare(b.filename) == .orderedAscending
            } else {
                return a.filename.localizedCaseInsensitiveCompare(b.filename) == .orderedDescending
            }
        }
    }

    /* func fetchImages() {
         guard !userLogin.isEmpty, !category.isEmpty else {
             return
         }

         let apiService = ApiService()

         apiService.getImages(userLogin: userLogin, category: category)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     break
                 case let .failure(error):
                     print("Error fetching images: \(error)")
                 }
             }, receiveValue: { response in
                 self.images = response.map { item in
                     MyImage(
                         id: item.id,
                         filename: item.filename,
                         image: self.convertBase64ToImage(base64String: item.data)
                     )
                 }
             })
             .store(in: &cancellables)
     } */

    func loadImages() {
        guard !userLogin.isEmpty, !category.isEmpty else {
            return
        }

        // let apiUrl = "http://localhost:8080/api"
        let apiUrl = "https://photo-gallery-api-59f6baae823c.herokuapp.com/api"

        category = category.replacePolishCharacters()

        AF.request("\(apiUrl)/images/\(userLogin)/\(category)").responseDecodable(of: [ImageResponse].self) { response in
            switch response.result {
            case let .success(images):
                self.images = images.map { item in
                    MyImage(
                        id: item.id,
                        filename: item.filename,
                        image: self.convertBase64ToImage(base64String: item.data)
                    )
                }
            // self.filteredImages = self.images
            case let .failure(error):
                print("Failed to load images: \(error)")
            }
        }
    }

    private func convertBase64ToImage(base64String: String) -> Image {
        // Convert base64String to UIImage
        if let imageData = Data(base64Encoded: base64String), let uiImage = UIImage(data: imageData) {
            // Convert UIImage to Image
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "photo")
        }
    }
}

struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ImageListView()
    }
}
