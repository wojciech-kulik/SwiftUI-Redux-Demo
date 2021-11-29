//
//  HomeView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct HomeView: View {
    @State var searchText = ""
    @EnvironmentObject var store: Store<AppState>

    var state: HomeState { store.state.state(for: .home, type: HomeState.self)! }

    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        return ZStack {
            Color.black.ignoresSafeArea()

            Text("")
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always)
                )

            List {
                ForEach(state.upcomingEpisodes) { episode in
                    ZStack {
                        UpcomingEpisodeView(episode: episode)
                            .listRowBackground(Color.clear)
                            .cornerRadius(8.0)
                            .padding(.bottom, 6.0)
                            .padding(.horizontal, 6.0)
                        NavigationLink(
                            isActive: Binding(
                                get: { episode.id == state.presentedEpisodeId },
                                set: {
                                    let currentValue = episode.id == state.presentedEpisodeId
                                    guard currentValue != $0 else { return }
                                    store.dispatch($0 ? ActiveScreensStateAction.showScreen(.episode(id: episode.id)) : .dismissScreen(.episode(id: episode.id)))
                                }
                            ),
                            destination: { EpisodeDetailsLoadingView(episodeId: episode.id) },
                            label: {}
                        ).opacity(0)
                    }.listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("TV Shows")
        .onLoad { store.dispatch(HomeStateAction.fetchUpcomingEpisodes) }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(store)
    }
}
