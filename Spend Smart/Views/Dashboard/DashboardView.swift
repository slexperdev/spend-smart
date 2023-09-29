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
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            CategoriesView()
                .tabItem{
                    Image(systemName: "folder.fill")
                    Text("Categories")
                }
            ReportView()
                .tabItem{
                    Image(systemName: "chart.pie.fill")
                    Text("Summery")
                }
            SettingsView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }

        }
        .accentColor(Color("GradientStart2"))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
