//
//  UserDetailsState.swift
//  ReduxDemo
//
//  Created by Hugues Telolahy on 01/04/2023.
//

import Foundation

struct UserDetailsState: Codable {
    let userId: UUID
    let details: User?
    let comments: [Comment]
    let isLoading: Bool
}

extension UserDetailsState {

    enum Action: ActionProtocol {
        case fetchUserProfile(userId: UUID)
        case didReceiveUserProfile(user: User, comments: [Comment])
    }

    static let reducer: Reducer<Self> = { state, action in
        guard let action = action as? Action else { return state }

        switch action {
        case .fetchUserProfile(let id):
            return .init(
                userId: id,
                details: nil,
                comments: [],
                isLoading: true
            )
        case .didReceiveUserProfile(let userDetails, let comments):
            return .init(
                userId: state.userId,
                details: userDetails,
                comments: comments,
                isLoading: false
            )
        }
    }
}

extension UserDetailsState {
    init(id: UUID) {
        userId = id
        details = nil
        comments = []
        isLoading = true
    }
}

