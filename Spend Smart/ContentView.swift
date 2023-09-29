//
//  ContentView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-08-30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userVm: UserViewModel
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            } else {
                if let isAuthenticated = UserDefaults.standard.value(forKey: "authenticated") as? Bool, isAuthenticated {
                    DashboardView()
                } else {
                    StartUpView()
                }
            }
        }
        .onAppear{
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 3)
            {
                withAnimation{
                    self.showSplash = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
    }
}
