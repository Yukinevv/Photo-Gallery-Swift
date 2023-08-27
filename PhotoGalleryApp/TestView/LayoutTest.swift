//
//  LoginForm.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 17/08/2023.
//

import SwiftUI

struct LayoutTestView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
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
                    .padding()

                    Spacer().frame(height: geometry.size.height * 0.15)

                    Text("Zaloguj się na swoje konto")
                        .font(.title)
                        .padding()

                    Spacer().frame(height: geometry.size.height * 0.02)

                    VStack {
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

                        Button(action: {
                            // loginUser()
                        }) {
                            Text("Zaloguj")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color.white)

                    Spacer()

                    VStack {
                        Text("Nie masz konta?")
                        NavigationLink(destination: EmptyView()) {
                            Text("Zarejestruj się")
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
}

struct LayoutTestView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutTestView()
    }
}
