//
//  ReduxDemoApp.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

let timelineRecorder = TimelineRecorderMiddleware()
let tvShows = TvShowsMiddleware()
let logger = LoggerMiddleware()
let hotReloader = HotReloader()
let store = Store(
    initial: AppState(),
    reducer: AppState.reducer,
    middlewares: [tvShows.middleware,
                  logger.middleware,
                  timelineRecorder.middleware,
                  hotReloader.middleware]
)

struct AppView: View {
    @EnvironmentObject var store: Store<AppState>

    var body: some View {
        if store.state.screenState(for: .home) as HomeState? != nil {
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
