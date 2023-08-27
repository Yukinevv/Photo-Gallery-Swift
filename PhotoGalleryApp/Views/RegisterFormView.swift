//
//  RegisterFormView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 19/08/2023.
//

import SwiftUI

struct RegisterFormView: View {
    @State private var login: String = ""
    @State private var email: String = ""
    @State private var password1: String = ""
    @State private var password2: String = ""
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""

    @State private var isInputInvalid1 = false
    @State private var isInputInvalid2 = false

    @Binding var isLoggedIn: Bool
    @Binding var userLogin: String

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer().frame(height: geometry.size.height * 0.08)

                    Text("Utwórz konto")
                        .font(.title)

                    VStack(alignment: .leading, spacing: 15) {
                        Text("Login")
                        TextField("Login", text: $login)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Email")
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Hasło")
                        SecureField("Hasło", text: $password1)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .modifier(InvalidInputModifier(isInvalid: $isInputInvalid1))
                            .onChange(of: password1) { newValue in
                                isInputInvalid1 = !isValid(newValue)
                            }

                        Text("Powtórz hasło")
                        SecureField("Powtórz hasło", text: $password2)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .modifier(InvalidInputModifier(isInvalid: $isInputInvalid2))
                            .onChange(of: password2) { newValue in
                                isInputInvalid2 = !isValid(newValue)
                            }

                        HStack {
                            Spacer()
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            if !successMessage.isEmpty {
                                Text(successMessage)
                                    .foregroundColor(Color(rgb: 17, green: 217, blue: 17))
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            Button(action: {
                                registerUser()
                            }) {
                                Text("Zarejestruj się")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: 180)
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
                    .padding(20)

                    Spacer()

                    VStack {
                        Text("Masz już konto?")
                        NavigationLink(destination: LoginFormView(isLoggedIn: $isLoggedIn, userLogin: $userLogin)) {
                            Text("Zaloguj się")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: 0xF0F0F0))
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func isValid(_ input: String) -> Bool {
        return input.count >= 5
    }

    func registerUser() {
        if password1 != password2 {
            errorMessage = "Podane hasła nie są takie same!"
            return
        } else if login.isEmpty || password1.isEmpty || email.isEmpty {
            errorMessage = "Uzupełnij wszystkie pola!"
            return
        } else if password1.count < 5 {
            errorMessage = "Hasło nie może mieć mniej niż 5 znaków!"
            return
        }

        let apiService = ApiService()

        let user = User(login: login, password: password1, email: email)

        apiService.createUser(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    print("Registration success, data received:", data)
                    errorMessage = ""
                    successMessage = "Konto zostało utworzone!"

                case let .failure(error):
                    print("Registration failure, error:", error)
                    errorMessage = "Wystąpił błąd podczas rejestracji!"
                }
            }
        }
    }
}

struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFormView(isLoggedIn: .constant(false), userLogin: .constant(""))
    }
}
