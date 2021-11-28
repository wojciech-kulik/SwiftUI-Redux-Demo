//
//  HomeView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        return ZStack {
            Color.black.ignoresSafeArea()

            List {
                ShowView(entry: .preview())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .cornerRadius(12.0)
                    .padding(.bottom, 6.0)
                ShowView(entry: .preview2())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .cornerRadius(8.0)
                ShowView(entry: .preview())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .cornerRadius(8.0)
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
