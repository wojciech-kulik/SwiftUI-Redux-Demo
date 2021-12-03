//
//  UserDetailsStateReducer.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

extension UserDetailsState {
    static let reducer: Reducer<Self> = { state, action in
        guard let action = action as? UserDetailsStateAction else { return state }

        switch action {
        case .fetchUserProfile(let id):
            return UserDetailsState(
                userId: id,
                details: nil,
                comments: [],
                isLoading: true
            )
        case .didReceiveUserProfile(let userDetails, let comments):
            return UserDetailsState(
                userId: state.userId,
                details: userDetails,
                comments: comments,
                isLoading: false
            )
        }
    }
}
