//
//  AnyCancellable.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Combine
import Foundation

extension AnyCancellable {
    func store(in dictionary: inout [UUID: AnyCancellable], key: UUID) {
        dictionary[key] = self
    }
}
