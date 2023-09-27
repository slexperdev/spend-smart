//
//  SettingsView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-17.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userVm : UserViewModel
    var body: some View {
        ZStack{
            Button{
                Task{
                   userVm.signOut()
                }
            } label: {
                Text("Logout")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserViewModel())
    }
}
