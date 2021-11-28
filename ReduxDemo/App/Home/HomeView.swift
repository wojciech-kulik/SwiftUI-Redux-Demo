//
//  HomeView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct HomeView: View {
    @State var searchText = ""

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
                ZStack {
                    UpcomingEpisodeView(entry: .mockGameOfThrones)
                        .listRowBackground(Color.clear)
                        .cornerRadius(8.0)
                        .padding(.bottom, 6.0)
                        .padding(.horizontal, 6.0)
                    NavigationLink(destination: { EpisodeDetailsLoadingView(episodeId: EpisodeDetails.mockGameOfThrones.id) }, label: {}).opacity(0)
                }.listRowSeparator(.hidden)
                ZStack {
                    UpcomingEpisodeView(entry: .mockBreakingBad)
                        .listRowBackground(Color.clear)
                        .cornerRadius(8.0)
                        .padding(.bottom, 6.0)
                        .padding(.horizontal, 6.0)
                    NavigationLink(destination: { EpisodeDetailsLoadingView(episodeId: EpisodeDetails.mockBreakingBad.id) }, label: {}).opacity(0)
                }.listRowSeparator(.hidden)
                ZStack {
                    UpcomingEpisodeView(entry: .mockGameOfThrones)
                        .listRowBackground(Color.clear)
                        .cornerRadius(8.0)
                        .padding(.bottom, 6.0)
                        .padding(.horizontal, 6.0)
                    NavigationLink(destination: { EpisodeDetailsLoadingView(episodeId: EpisodeDetails.mockGameOfThrones.id) }, label: {}).opacity(0)
                }.listRowSeparator(.hidden)
            }.listStyle(.plain)
        }
        .navigationTitle("TV Shows")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
