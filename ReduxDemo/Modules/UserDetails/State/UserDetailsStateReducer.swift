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

        return state
    }
}
