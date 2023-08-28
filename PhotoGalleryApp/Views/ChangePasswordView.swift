//
//  ChangePasswordView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import Combine
import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmNewPassword = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""

    @State private var isShowingConfirmationDialog = false

    @State private var cancellables = Set<AnyCancellable>()

    @State private var isInputInvalid1 = false
    @State private var isInputInvalid2 = false

    var userLogin: String = ""

    var body: some View {
        VStack {
            Text("Zmień swoje hasło")
                .font(.title)
                .padding()

            VStack(alignment: .leading, spacing: 15) {
                Text("Obecne hasło:")
                SecureField("Obecne hasło", text: $currentPassword)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Nowe hasło:")
                SecureField("Nowe hasło", text: $newPassword)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .modifier(InvalidInputModifier(isInvalid: $isInputInvalid1))
                    .onChange(of: newPassword) { newValue in
                        isInputInvalid1 = !isValid(newValue)
                    }

                Text("Potwierdź nowe hasło:")
                SecureField("Potwierdź nowe hasło", text: $confirmNewPassword)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .modifier(InvalidInputModifier(isInvalid: $isInputInvalid2))
                    .onChange(of: confirmNewPassword) { newValue in
                        isInputInvalid2 = !isValid(newValue)
                    }

                HStack {
                    Spacer()
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    if !successMessage.isEmpty {
                        Text(successMessage)
                            .foregroundColor(.green)
                    }
                    Spacer()
                }

                HStack {
                    Spacer()
                    Button(action: {
                        isShowingConfirmationDialog = true
                    }) {
                        Text("Zmień hasło")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 180) // .infinity
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $isShowingConfirmationDialog) {
                        Alert(
                            title: Text("Zmiana hasła"),
                            message: Text("Czy na pewno chcesz zmienić swoje hasło?"),
                            primaryButton: .default(Text("Tak")) {
                                changePassword()
                            },
                            secondaryButton: .cancel(Text("Nie"))
                        )
                    }
                    Spacer()
                }
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(8)
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0xF0F0F0))
    }

    func isValid(_ input: String) -> Bool {
        return input.count >= 5
    }

    func changePassword() {
        if userLogin.isEmpty {
            return
        }

        if currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty {
            errorMessage = "Pola nie mogą być puste!"
            return
        } else if newPassword != confirmNewPassword {
            errorMessage = "Nowo podane hasła nie są takie same!"
            return
        } else if currentPassword == newPassword {
            errorMessage = "Obecne oraz nowe hasło nie może być takie same!"
            return
        } else if newPassword.count < 5 {
            errorMessage = "Hasło nie może mieć mniej niż 5 znaków!"
            return
        }

        // let apiUrl = "http://localhost:8080/api"
        let apiUrl = "https://photo-gallery-api-59f6baae823c.herokuapp.com/api"

        let url = URL(string: "\(apiUrl)/users/editPassword/\(userLogin)/\(currentPassword)/\(newPassword)")!

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
                    print("Error while changing user password: \(error)")
                }
            }, receiveValue: { response in
                if response["message"] == "Wrong password" {
                    errorMessage = "Podano niepoprawne hasło!"
                    currentPassword = ""
                } else {
                    successMessage = "Hasło zostało zmienione!"
                    errorMessage = ""
                    currentPassword = ""
                    newPassword = ""
                    confirmNewPassword = ""
                }
            })
            .store(in: &cancellables)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
