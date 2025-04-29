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
    let searchText: String
}

extension HomeState {
    init() {
        upcomingEpisodes = [.mockGameOfThrones, .mockBreakingBad]
        isLoading = false
        presentedEpisodeId = nil
        searchText = ""
    }
}
