//
//  TestImageList.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 22/08/2023.
//

import Combine
import SwiftUI

struct TestImageListView: View {
    @State private var images: [MyImage] = []
    @State private var userLogin = ""
    @State private var category = ""

    @State private var cancellables: [AnyCancellable] = []
    private let apiService = ApiService2()

    var body: some View {
        VStack {
            TextField("User Login", text: $userLogin)
                .autocapitalization(.none)
                .padding()

            TextField("Category", text: $category)
                .autocapitalization(.none)
                .padding()

            Button("Fetch Images") {
                fetchImages()
            }

            List(images, id: \.id) { image in
                image.image
                Text(image.filename)
            }
        }
    }

    func fetchImages() {
        guard !userLogin.isEmpty, !category.isEmpty else {
            return
        }

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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestImageListView()
    }
}

class ApiService2 {
    private let apiUrl = "http://localhost:8080/api"

    func getImages(userLogin: String, category: String) -> AnyPublisher<[ImageResponse], Error> {
        let url = URL(string: "\(apiUrl)/images/\(userLogin)/\(category)")!

        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .map { data, _ in
                // print(String(data: data, encoding: .utf8) ?? "")
                data
            }
            .decode(type: [ImageResponse].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
