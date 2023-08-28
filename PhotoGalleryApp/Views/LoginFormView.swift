//
//  LoginFormView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 17/08/2023.
//

import SwiftUI

struct LoginFormView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    @Binding var isLoggedIn: Bool
    @Binding var userLogin: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Photo Gallery")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .fontWeight(.bold)
                }
                .padding(.init(top: 30, leading: 0, bottom: 0, trailing: 0))

                Spacer()

                VStack {
                    Text("Zaloguj się na swoje konto")
                        .font(.title)

                    VStack(alignment: .leading, spacing: 15) {
                        Text("Login")
                        TextField("Login", text: $login)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Hasło")
                        SecureField("Hasło", text: $password)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        HStack {
                            Spacer()
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            Button(action: {
                                loginUser()
                            }) {
                                Text("Zaloguj")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: 150)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            Spacer()
                        }
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.init(top: 15, leading: 20, bottom: 20, trailing: 20))
                }

                Spacer()

                VStack {
                    Text("Nie masz konta?")
                    NavigationLink(destination: RegisterFormView(isLoggedIn: $isLoggedIn, userLogin: $userLogin)) {
                        Text("Zarejestruj się")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
            }
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
                    userLogin = login
                    isLoggedIn = true

                case let .failure(error):
                    print("Login failure, error:", error)
                    errorMessage = "Podano błędne dane!"
                }
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(isLoggedIn: .constant(false), userLogin: .constant(""))
    }
}
