//
//  EpisodeDetailsLoadingView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct EpisodeDetailsLoadingView: View {
    @State var details: EpisodeDetails?
    @State var episodeId: UUID

    var body: some View {
        if let details = details {
            EpisodeDetailsView(details: details)
        } else {
            ProgressView(label: { Text("Loading details") })
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        details = EpisodeDetails.allMocks.first { $0.id == episodeId }!
                    }
                }
        }
    }
}

struct EpisodeDetailsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsLoadingView(details: nil, episodeId: UUID())
    }
}
