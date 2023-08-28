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
        // GeometryReader { geometry in
        VStack(spacing: 0) {
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
            // .frame(height: geometry.size.height - 10)

            /* if selectedTab == 1 {
                 Rectangle()
                     .fill(Color(hex: 0xF0F0F0))
                     .frame(height: 10)
                     .edgesIgnoringSafeArea(.bottom)
             } */
        }
        // }
        .navigationBarBackButtonHidden(true)
    }
}
