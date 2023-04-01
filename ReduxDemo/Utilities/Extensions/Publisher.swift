//
//  Publisher.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 29/11/2021.
//

import Combine

extension Publisher {
    func ignoreError() -> AnyPublisher<Output, Never> {
        self
        .catch { _ in Empty() }
        .eraseToAnyPublisher()
    }
}
