//
//  Spend_SmartApp.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-08-30.
//

import SwiftUI
import Firebase

@main
struct Spend_SmartApp: App {
    @StateObject var userVm = UserViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
            }
            .environmentObject(userVm)
        }
    }
}
