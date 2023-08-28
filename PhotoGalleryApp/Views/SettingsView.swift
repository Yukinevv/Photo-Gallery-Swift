//
//  SettingsView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

struct SettingsView: View {
    @State var isSheetPresented: Bool = false

    @Binding var isLoggedIn: Bool
    var userLogin: String = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Użytkownik")) {
                    NavigationLink(destination: ChangePasswordView(userLogin: userLogin)) {
                        Text("Zmień hasło")
                            .foregroundColor(.black)
                    }

                    Button(action: {
                        isLoggedIn = false
                    }) {
                        Text("Wyloguj")
                            .foregroundColor(.black)
                    }
                }

                Section(header: Text("Inne")) {
                    Link("Link do API", destination: URL(string: "https://photo-gallery-api-59f6baae823c.herokuapp.com/api/users")!)
                }
            }
            .listStyle(GroupedListStyle())
            // .background(Color(hex: 0xF0F0F0))

            .navigationTitle("Ustawienia")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isLoggedIn: .constant(true))
    }
}
