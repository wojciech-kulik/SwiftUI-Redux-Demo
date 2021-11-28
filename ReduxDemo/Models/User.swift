//
//  User.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct User {
    let avatar: String
    let name: String
    let signUpDate: Date
    let location: String
}

extension User {
    static let mock = User(avatar: "avatar", name: "John Snow", signUpDate: Date().addingTimeInterval(-400 * 24 * 3600), location: "Wrocław, Poland")
}
