//
//  EpisodeDetailsLoadingView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct EpisodeDetailsLoadingView: View {
    let episodeId: UUID
    
    @EnvironmentObject var store: Store<AppState>
    private var state: EpisodeDetailsState? { store.state.screenState(for: .episode(id: episodeId)) }

    @ViewBuilder
    var body: some View {
        if let details = state?.details {
            EpisodeDetailsView(details: details)
        } else if state?.isLoading == true {
            SpinnerView("Loading Details")
                .animation(nil, value: UUID())
                .onLoad { store.dispatch(EpisodeDetailsState.Action.fetchEpisodeDetails(id: episodeId)) }
        }
    }
}

struct EpisodeDetailsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsLoadingView(episodeId: UUID())
            .environmentObject(store)
    }
}
