//
//  User.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 19/08/2023.
//

import Foundation

class User: Encodable {
    var login: String
    var password: String
    var email: String

    init(login: String, password: String, email: String) {
        self.login = login
        self.password = password
        self.email = email
    }
}
