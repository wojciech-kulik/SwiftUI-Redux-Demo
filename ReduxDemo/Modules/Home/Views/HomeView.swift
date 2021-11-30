//
//  HomeView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: Store<AppState>

    var state: HomeState? { store.state.state(for: .home, type: HomeState.self) }

    var noEpisodesPlaceholder: some View {
        Text("Could not find episodes")
            .font(.title2)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(32.0)
    }

    var body: some View {
        ZStack {
            Text("")
                .searchable(
                    text: Binding(get: { state?.searchText ?? "" }, set: { store.dispatch(HomeStateAction.filterEpisodes(phrase: $0)) }),
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .disableAutocorrection(true)

            if let state = state, !state.isLoading {
                if state.upcomingEpisodes.isEmpty {
                    noEpisodesPlaceholder.animation(nil, value: UUID())
                } else {
                    createEpisodesList()
                }
            } else {
                ProgressView().tint(.yellow)
            }
        }
        .background(.black)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("TV Shows")
        .onLoad { store.dispatch(HomeStateAction.fetchUpcomingEpisodes) }
    }

    private func createEpisodesList() -> some View {
        List {
            ForEach(state?.upcomingEpisodes ?? []) { episode in
                ZStack {
                    Button(
                        action: {
                            UIApplication.shared.endEditing()
                            store.dispatch(ActiveScreensStateAction.showScreen(.episode(id: episode.id)))
                        },
                        label: {
                            UpcomingEpisodeView(episode: episode)
                                .listRowBackground(Color.clear)
                                .cornerRadius(8.0)
                                .padding(.bottom, 6.0)
                                .padding(.horizontal, 6.0)
                        }
                    )
                    NavigationLink(
                        isActive: Binding(
                            get: { episode.id == state?.presentedEpisodeId },
                            set: { isActive in
                                let currentValue = episode.id == state?.presentedEpisodeId
                                guard currentValue != isActive, !isActive else { return }
                                store.dispatch(ActiveScreensStateAction.dismissScreen(.episode(id: episode.id)))
                            }
                        ),
                        destination: { EpisodeDetailsLoadingView(episodeId: episode.id) },
                        label: {}
                    ).hidden()
                }.listRowSeparator(.hidden)
            }
        }.listStyle(.plain)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView().environmentObject(store)
        }
    }
}
