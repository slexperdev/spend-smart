//
//  DashboardView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-15.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            CategoriesView()
                .tabItem{
                    Image(systemName: "bag")
                    Text("Categories")
                }
            SettingsView()
                .tabItem{
                    Image(systemName: "slider.horizontal.3")
                    Text("Settings")
                }
        }
        .accentColor(Color("green"))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
