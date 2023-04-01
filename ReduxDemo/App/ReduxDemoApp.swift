//
//  ReduxDemoApp.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

let timelineRecorder = TimelineRecorderMiddleware()
let store = Store(
    initial: AppState(),
    reducer: AppState.reducer,
    middlewares: [Middlewares.tvShows,
                  Middlewares.logger,
                  timelineRecorder.middleware,
                  HotReloader().middleware]
)

struct AppView: View {
    @EnvironmentObject var store: Store<AppState>

    var body: some View {
        if store.state.screenState(for: .home) as Home.State? != nil {
            NavigationView {
                HomeView()
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
        UINavigationBar.appearance().tintColor = .systemYellow
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemYellow

        return WindowGroup {
            AppView()
                .tint(.yellow)
                .foregroundColor(.primary)
                .environmentObject(store)
        }
    }
}
