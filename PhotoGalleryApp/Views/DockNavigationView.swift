//
//  DockNavigationView.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

struct DockNavigationView: View {
    @State private var selectedTab = 0

    @Binding var isLoggedIn: Bool
    var userLogin: String = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            CategoryListView(userLogin: userLogin)
                .tabItem {
                    Image(systemName: "camera")
                    Text("Galeria")
                }
                .tag(0)

            SettingsView(isLoggedIn: $isLoggedIn, userLogin: userLogin)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Ustawienia")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden(true)
    }
}
