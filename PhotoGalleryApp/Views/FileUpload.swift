//
//  FileUpload.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 22/08/2023.
//

import Alamofire
import FilePicker
import SwiftUI

struct FileUploadView: View {
    @State private var selectedFile: URL?
    @State private var fileName: String = ""
    @State private var errorMessage: String = "Brak wybranego pliku."
    @State private var isButtonDisabled: Bool = true

    var userLogin: String = ""
    @State var category: String = ""

    @Binding var isSheetPresented: Bool

    var loadImages: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Button(action: {
                    self.uploadImage()
                }) {
                    Text("Dodaj obraz")
                        .padding()
                        .background(isButtonDisabled ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(isButtonDisabled ? 0.5 : 1.0)
                }
                .disabled(isButtonDisabled)

                Text(errorMessage)
                    .padding(20)

                FilePicker(types: [.jpeg, .png], allowMultiple: false) { urls in
                    print("selected \(urls.count) files")
                    self.selectedFile = urls[0]
                    self.fileName = urls[0].lastPathComponent

                    if isFileTypeAllowed(fileURL: urls[0]) {
                        self.errorMessage = "Wybrany plik: \(fileName)"
                        self.isButtonDisabled = false
                    } else {
                        self.errorMessage = "Nieprawidłowy format pliku. Proszę wybrać plik .jpg lub .png"
                        self.isButtonDisabled = true
                    }
                } label: {
                    HStack {
                        Image(systemName: "doc.on.doc")
                        Text("Wybierz plik")
                    }
                }
            }
            .padding(.init(top: 20, leading: 50, bottom: 20, trailing: 50))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )

            Spacer()
        }
    }

    func isFileTypeAllowed(fileURL: URL) -> Bool {
        let allowedExtensions = ["jpg", "jpeg", "png"]
        let fileExtension = fileURL.pathExtension.lowercased()
        return allowedExtensions.contains(fileExtension)
    }

    func uploadImage() {
        // let userLogin = UserDefaults.standard.string(forKey: "userLogin") ?? "jank1"
        // let category = UserDefaults.standard.string(forKey: "category") ?? "Sport"

        if userLogin.isEmpty || category.isEmpty {
            return
        }

        guard let selectedFile = selectedFile else {
            print("brak wybranego pliku")
            return
        }

        category = category.replacePolishCharacters()

        let apiURL = "http://localhost:8080/api"

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(selectedFile, withName: "image", fileName: selectedFile.lastPathComponent, mimeType: "image/jpeg")
            },
            to: "\(apiURL)/images/upload/\(userLogin)/\(category)",
            method: .post,
            headers: HTTPHeaders(["Content-Type": "multipart/form-data"])
        )
        .response { response in
            switch response.result {
            case let .success(data):
                if let responseData = data {
                    // You can decode responseData if it's JSON, or handle it as needed
                    print("Sukces: \(responseData)")
                    loadImages()
                    isSheetPresented = false
                }
            case let .failure(error):
                print("Image upload failed: \(error)")
            }
        }
    }
}

struct FileUploadView_Previews: PreviewProvider {
    static var previews: some View {
        FileUploadView(isSheetPresented: .constant(true), loadImages: {})
    }
}
