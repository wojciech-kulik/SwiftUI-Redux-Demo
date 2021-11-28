//
//  HomeState.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import Foundation

struct HomeState: Codable {
    let upcomingEpisodes: [UpcomingEpisode]
    let isLoading: Bool
    let presentedEpisodeId: UUID?
}

extension HomeState {
    init() {
        upcomingEpisodes = []
        isLoading = true
        presentedEpisodeId = nil
    }
}
