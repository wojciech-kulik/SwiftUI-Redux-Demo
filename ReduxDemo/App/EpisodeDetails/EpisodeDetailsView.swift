//
//  EpisodeDetailsView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct EpisodeDetailsView: View {
    @State var details: EpisodeDetails
    @State var comment: String = ""

    var headerView: some View {
        VStack(spacing: 0.0) {
            Image(details.photo)
                .resizable()
                .frame(height: 240)
                .aspectRatio(contentMode: .fill)

            Text(details.title)
                .font(.title)
                .padding()

            Text("S\(details.season, specifier: "%02d")E\(details.episode, specifier: "%02d")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

    @ViewBuilder
    var descriptionView: some View {
        Text("Description:")
            .foregroundColor(.gray)
            .padding(.top, 20.0)
            .padding(.vertical)

        Text(details.description)
    }

    @ViewBuilder
    var commentsView: some View {
        Text("Comments:")
            .foregroundColor(.gray)
            .padding(.top, 20.0)
            .padding(.vertical)

        TextEditor(text: $comment)
            .background(.white)
            .foregroundColor(.black)
            .frame(height: 120)
            .cornerRadius(6.0)

        ForEach(0..<3) { _ in
            CommentView(comment: .mock)
                .padding(.vertical, 16.0)
        }.padding(.top, 24.0)
    }

    var body: some View {
        UITextView.appearance().backgroundColor = .clear

        return ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                headerView

                VStack(alignment: .leading, spacing: 0.0) {
                    descriptionView
                    commentsView
                }.padding(.horizontal, 24.0)
            }
        }
        .ignoresSafeArea(edges: [.top])
        .tint(.black)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in

        }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(details: .mock)
    }
}
