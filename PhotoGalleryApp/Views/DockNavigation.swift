//
//  DockNavigation.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import SwiftUI

struct DockNavigationView: View {
    @State private var selectedTab = 0 // Set the initial selected tab to 0 (MainView)

    @Binding var isLoggedIn: Bool
    var userLogin: String = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            CategoryListView(userLogin: userLogin)
                .tabItem {
                    Image(systemName: "camera")
                    Text("Galeria")
                }
                .tag(0) // Tag the MainView with 0

            SettingsView(isLoggedIn: $isLoggedIn, userLogin: userLogin)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Ustawienia")
                }
                .tag(1) // Tag the SettingsView with 1
        }
        .navigationBarBackButtonHidden(true)
    }
}
