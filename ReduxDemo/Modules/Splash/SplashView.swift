//
//  SplashView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("logo")
                .resizable()
                .frame(width: 120.0, height: 120.0, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        store.dispatch(AppState.Action.showScreen(.home))
                    }
                }
            VStack(spacing: 8) {
                Spacer()
                Text("Wojciech Kulik").font(.subheadline).foregroundColor(.primary)
                Text("wojciechkulik.pl").font(.subheadline).foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
