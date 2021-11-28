//
//  SplashView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct SplashView: View {
    var onDidFinish: (() -> ())?

    var body: some View {
        Image("splash")
            .resizable()
            .frame(width: 160.0, height: 160.0, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(80.0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    onDidFinish?()
                }
            }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
