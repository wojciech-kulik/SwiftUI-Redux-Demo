//
//  UIApplication.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 30/11/2021.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
