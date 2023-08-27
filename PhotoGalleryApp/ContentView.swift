//
//  ContentView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 17/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    @State private var userLogin: String = ""

    var body: some View {
        VStack {
            if isLoggedIn {
                DockNavigationView(isLoggedIn: $isLoggedIn, userLogin: userLogin)
            } else {
                LoginFormView(isLoggedIn: $isLoggedIn, userLogin: $userLogin)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
