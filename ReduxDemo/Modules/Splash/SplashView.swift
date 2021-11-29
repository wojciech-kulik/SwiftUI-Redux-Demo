//
//  SplashView.swift
//  ReduxDemo
//
//  Created by Wojciech Kulik on 28/11/2021.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .frame(width: 120.0, height: 120.0, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    store.dispatch(ActiveScreensStateAction.showScreen(.home))
                }
            }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
