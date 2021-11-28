//
//  EpisodeDetailsLoadingView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

fileprivate var lastState: EpisodeDetailsState?

struct EpisodeDetailsLoadingView: View {
    @State var episodeId: UUID
    @EnvironmentObject var store: Store<AppState>

    var state: EpisodeDetailsState? {
        let state = store.state.state(for: .episode(id: episodeId), type: EpisodeDetailsState.self)
        lastState = state ?? lastState
        return lastState
    }

    @ViewBuilder
    var body: some View {
        if let details = state?.details {
            EpisodeDetailsView(details: details).environmentObject(store)
        } else {
            ProgressView(label: { Text("Loading details") })
                .onLoad { store.dispatch(EpisodeDetailsAction.fetchEpisodeDetails(id: episodeId)) }
        }
    }
}

struct EpisodeDetailsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsLoadingView(episodeId: UUID())
            .environmentObject(store)
    }
}
