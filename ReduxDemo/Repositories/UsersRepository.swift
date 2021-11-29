//
//  UsersRepository.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import Foundation
import Combine

enum UsersRepositoryError: Error {
    case unknown
    case couldNotFind
}

final class UsersRepository: ObservableObject {
    private let users: [User] = [User.mock, User.mock2]

    func fetchUser(id: UUID) -> AnyPublisher<User, UsersRepositoryError> {
        if let user = users.first(where: { $0.id == id }) {
            return Just(user)
                .delay(for: 1.5, scheduler: DispatchQueue.main)
                .setFailureType(to: UsersRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: UsersRepositoryError.couldNotFind)
                .delay(for: 1.5, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
