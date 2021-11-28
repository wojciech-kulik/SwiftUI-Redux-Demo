//
//  MainNavigationController.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import UIKit
import SwiftUI
import Combine

final class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationBar.isHidden = true

        let splashView = SplashView { [weak self] in
            store.dispatch(AppStateAction.appDidLoad)
            store.dispatch(ActiveScreensStateAction.showScreen(.home))
            
            let homeView = HomeView()
                .environmentObject(store)
            let home = UIHostingController(rootView: homeView)
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                self?.viewControllers[0].view.alpha = 0.0
            }, completion: { _ in
                self?.navigationBar.isHidden = false
                home.view.alpha = 0.0
                self?.viewControllers = [home]
                UIView.animate(withDuration: 0.2) { home.view.alpha = 1.0 }
            })
        }
        viewControllers = [UIHostingController(rootView: splashView)]
    }
}
