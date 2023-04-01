//
//  HomeView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: Store<AppState>
    private var state: HomeState? { store.state.screenState(for: .home) }

    var noEpisodesPlaceholder: some View {
        Text("Could not find episodes")
            .font(.title2)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(32.0)
    }

    var searchBar: some View {
        Text("")
            .searchable(
                text: Binding(get: { state?.searchText ?? "" }, set: { store.dispatch(HomeState.Action.filterEpisodes(phrase: $0)) }),
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .disableAutocorrection(true)
    }

    var body: some View {
        ZStack {
            searchBar
            
            if let state = state, !state.isLoading {
                if state.upcomingEpisodes.isEmpty {
                    noEpisodesPlaceholder.animation(nil, value: UUID())
                } else {
                    createEpisodesList()
                }
            } else {
                SpinnerView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("TV Shows")
        .addReplayButton()
        .onLoad { store.dispatch(HomeState.Action.fetchUpcomingEpisodes) }
    }

    private func createEpisodesList() -> some View {
        List {
            ForEach(state?.upcomingEpisodes ?? []) { episode in
                ZStack {
                    episodeRow(for: episode)
                    navigation(for: episode)
                }.listRowSeparator(.hidden)
            }
        }.listStyle(.plain)
    }

    private func episodeRow(for episode: UpcomingEpisode) -> some View {
        Button(
            action: {
                store.dispatch(AppState.Action.showScreen(.episode(id: episode.id)))
            },
            label: {
                UpcomingEpisodeView(episode: episode)
                    .cornerRadius(8.0)
                    .padding(.bottom, 6.0)
                    .padding(.horizontal, 6.0)
            }
        )
    }

    private func navigation(for episode: UpcomingEpisode) -> some View {
        NavigationLink(
            isActive: Binding(
                get: { episode.id == state?.presentedEpisodeId },
                set: { isActive in
                    let currentValue = episode.id == state?.presentedEpisodeId
                    guard currentValue != isActive, !isActive else { return }
                    store.dispatch(AppState.Action.dismissScreen(.episode(id: episode.id)))
                }
            ),
            destination: { EpisodeDetailsLoadingView(episodeId: episode.id) },
            label: {}
        ).hidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView().environmentObject(store)
        }
    }
}
