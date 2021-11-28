//
//  ReduxDemoApp.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

let store = Store(
    initial: AppState(),
    reducer: AppState.reducer,
    middlewares: [Middlewares.tvShows, Middlewares.logger]
)

struct AppView: View {
    @EnvironmentObject var store: Store<AppState>

    var body: some View {
        if store.state.state(for: .home, type: HomeState.self) != nil {
            NavigationView {
                HomeView().environmentObject(store)
            }
            .navigationViewStyle(.stack)
        } else {
            SplashView()
        }
    }
}

@main
struct ReduxDemoApp: App {
    var body: some Scene {
        UINavigationBar.appearance().tintColor = .yellow

        return WindowGroup {
            AppView().environmentObject(store)
        }
    }
}
