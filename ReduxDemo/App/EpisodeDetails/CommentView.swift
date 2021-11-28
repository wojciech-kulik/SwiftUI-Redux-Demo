//
//  CommentView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct CommentView: View {
    let canPresentProfile: Bool

    @State var comment: Comment
    @State var isUserProfileVisible = false

    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            if canPresentProfile {
                Button {
                    isUserProfileVisible = true
                } label: {
                    Image(comment.avatar)
                        .resizable()
                        .frame(width: 60.0, height: 60.0)
                }
            } else {
                Image(comment.avatar)
                    .resizable()
                    .frame(width: 60.0, height: 60.0)
            }

            VStack(alignment: .leading, spacing: 6.0) {
                Text("\(comment.name) • \(comment.date, format: .relative(presentation: .named))")
                    .fontWeight(.bold)
                Text(comment.text)
            }
        }.sheet(isPresented: $isUserProfileVisible) {
            UserDetailsView(user: .mock)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(canPresentProfile: true, comment: .mock)
    }
}
