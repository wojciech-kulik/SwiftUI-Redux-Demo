//
//  User.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct User {
    let id: UUID
    let avatar: String
    let name: String
    let signUpDate: Date
    let location: String
}

extension User {
    static let mock = User(id: UUID(), avatar: "avatar", name: "John Snow", signUpDate: Date().addingTimeInterval(-400 * 24 * 3600), location: "Wrocław, Poland")
    static let mock2 = User(id: UUID(), avatar: "avatar2", name: "Anaïs Augustin", signUpDate: Date().addingTimeInterval(-700 * 24 * 3600), location: "Paris, France")
}
