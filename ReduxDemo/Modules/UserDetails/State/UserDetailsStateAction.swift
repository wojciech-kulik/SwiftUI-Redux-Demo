//
//  UserDetailsStateAction.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

enum UserDetailsStateAction: Action {
    case fetchUserProfile(userId: UUID)
    case didReceiveUserProfile(user: User, comments: [Comment])
}
