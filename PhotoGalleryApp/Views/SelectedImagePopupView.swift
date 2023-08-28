//
//  SelectedImagePopupView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 21/08/2023.
//

import Combine
import SwiftUI

struct SelectedImagePopupView: View {
    @State private var newFilename: String = ""
    @State private var errorMessage: String = ""
    @State var selectedImage: MyImage?

    @State private var isDialogVisible = false
    @State private var isDialogVisible2 = false

    @State private var cancellables = Set<AnyCancellable>()

    var loadImages: () -> Void
    var onClose: () -> Void

    var body: some View {
        VStack {
            Text("Podaj nazwę zdjęcia:")
                .font(.headline)
                .padding()

            TextField("New Filename", text: $newFilename)
                .autocapitalization(.none)
                .padding()

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                isDialogVisible2.toggle()
            }) {
                Text("Zmień nazwę")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $isDialogVisible2) {
                Alert(
                    title: Text("Zmiana nazwy"),
                    message: Text("Czy na pewno chcesz zmienić nazwę tego obrazu?"),
                    primaryButton: .default(Text("Tak")) {
                        changeFilename()
                    },
                    secondaryButton: .cancel(Text("Nie"))
                )
            }

            Spacer()

            if let image = selectedImage {
                image.image
                    .resizable()
                    .frame(width: 200, height: 200)

                Text(image.filename)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    isDialogVisible.toggle()
                }) {
                    Text("Usuń zdjęcie")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $isDialogVisible) {
                    Alert(
                        title: Text("Usunięcie obrazu"),
                        message: Text("Czy na pewno chcesz usunąć ten obraz?"),
                        primaryButton: .destructive(Text("Tak")) {
                            deleteImage()
                        },
                        secondaryButton: .cancel(Text("Nie"))
                    )
                }

                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }

    func changeFilename() {
        let imageId = selectedImage?.id ?? ""

        if imageId.isEmpty || newFilename.isEmpty {
            errorMessage = "Nie podano nowej nazwy!"
            return
        }

        // let apiUrl = "http://localhost:8080/api"
        let apiUrl = "https://photo-gallery-api-59f6baae823c.herokuapp.com/api"

        let url = URL(string: "\(apiUrl)/images/editFilename/\(imageId)/\(newFilename)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [String: String].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Error changing image filename", error)
                }
            }, receiveValue: { response in
                print(response)
                selectedImage?.filename = newFilename
                loadImages()
            })
            .store(in: &cancellables)
    }

    func deleteImage() {
        let imageId = selectedImage?.id ?? ""

        // let apiUrl = "http://localhost:8080/api"
        let apiUrl = "https://photo-gallery-api-59f6baae823c.herokuapp.com/api"

        let url = URL(string: "\(apiUrl)/images/delete/\(imageId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [String: String].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Error deleting image", error)
                }
            }, receiveValue: { response in
                if let message = response["message"] {
                    print("Success: \(message)")
                    loadImages()
                    onClose()
                } else {
                    print("Unexpected response format")
                }
            })
            .store(in: &cancellables)
    }
}

struct SelectedImagePopupView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedImagePopupView(selectedImage: MyImage(id: "1", filename: "test", image: Image(systemName: "photo")), loadImages: {}, onClose: {})
    }
}
