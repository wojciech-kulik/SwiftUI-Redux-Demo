//
//  EpisodeDetailsLoadingView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct EpisodeDetailsLoadingView: View {
    @State var episodeId: UUID
    @EnvironmentObject var store: Store<AppState>

    var state: EpisodeDetailsState? { store.state.state(for: .episode(id: episodeId), type: EpisodeDetailsState.self) }

    @ViewBuilder
    var body: some View {
        if let details = state?.details {
            EpisodeDetailsView(details: details)
        } else if state?.isLoading == true {
            ProgressView(label: {
                Text("Loading details")
                    .foregroundColor(.yellow)
            })
            .tint(.yellow)
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
