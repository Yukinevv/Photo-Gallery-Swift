//
//  OldLoginView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 17/08/2023.
//

import SwiftUI

struct OldLoginView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Zaloguj się na swoje konto")
                    .font(.title)

                Form {
                    Section {
                        TextField("Login", text: $login)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        SecureField("Hasło", text: $password)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }

                        HStack {
                            Spacer()
                            Button(action: {
                                loginUser()
                            }) {
                                Text("Zaloguj")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding()
                            Spacer()
                        }
                    }
                }

                VStack {
                    Text("Nie masz konta?")
                    NavigationLink(destination: EmptyView()) {
                        Text("Zarejestruj się")
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xF0F0F0))
        }
        .navigationBarBackButtonHidden(true)
    }

    func loginUser() {
        if login.isEmpty || password.isEmpty {
            errorMessage = "Uzupełnij wszystkie pola!"
            return
        }

        let apiService = ApiService()

        let user = User(login: login, password: password, email: "")

        apiService.login(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    print("Login success, data received:", data)
                    errorMessage = ""
                    isLoggedIn = true

                case let .failure(error):
                    print("Login failure, error:", error)
                    errorMessage = "Podano błędne dane!"
                }
            }
        }
    }
}

struct OldLoginForm_Previews: PreviewProvider {
    static var previews: some View {
        OldLoginView()
    }
}
