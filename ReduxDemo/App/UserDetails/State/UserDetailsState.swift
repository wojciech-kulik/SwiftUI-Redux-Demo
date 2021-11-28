//
//  UserDetailsState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct UserDetailsState: Codable {
    let userId: UUID
    let details: User?
    let comments: [Comment]
    let isLoading: Bool
    let isLoadingComments: Bool
}

extension UserDetailsState {
    init(id: UUID) {
        userId = id
        details = nil
        comments = []
        isLoading = true
        isLoadingComments = true
    }
}
