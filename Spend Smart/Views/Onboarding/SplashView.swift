//
//  SplashView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-08-31.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                Image("applogo")
                Text("SpendSmart").font(.system(size: 40)).bold()
                Text("Your personal money manager").font(.system(size: 20)).padding(.top, 0.5)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
