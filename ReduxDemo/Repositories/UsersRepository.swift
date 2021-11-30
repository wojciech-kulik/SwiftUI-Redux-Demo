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
    private let simulatedDelay: RunLoop.SchedulerTimeType.Stride = 1.0

    private let users: [User] = [User.mock, User.mock2]

    func fetchUser(id: UUID) -> AnyPublisher<User, UsersRepositoryError> {
        if let user = users.first(where: { $0.id == id }) {
            return Just(user)
                .delay(for: simulatedDelay, scheduler: RunLoop.main)
                .setFailureType(to: UsersRepositoryError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: UsersRepositoryError.couldNotFind)
                .delay(for: simulatedDelay, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }
}
