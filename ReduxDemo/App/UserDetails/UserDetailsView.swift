//
//  UserDetailsView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct UserDetailsView: View {
    @State var user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Image(user.avatar)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)

                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Joined: \(user.signUpDate, format: .relative(presentation: .named))")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Location: \(user.location)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Comments")
                    .font(.title3)
                    .padding(.top, 24.0)

                ForEach(0..<3) { _ in
                    CommentView(canPresentProfile: false, comment: .mock)
                        .padding(.top, 24.0)
                }
            }
            .padding(16.0)
            .padding(.top, 24.0)
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: .mock)
    }
}
