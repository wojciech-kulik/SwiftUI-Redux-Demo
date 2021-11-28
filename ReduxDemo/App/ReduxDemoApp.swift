//
//  ReduxDemoApp.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        UINavigationBar.appearance().tintColor = UIColor.yellow.withAlphaComponent(0.9)

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.backgroundColor = .white

        window.rootViewController = MainNavigationController()
        window.makeKeyAndVisible()
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
