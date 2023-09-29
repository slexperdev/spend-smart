//
//  SettingsView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-17.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userVm : UserViewModel
    @State private var isLogoutActive = false 
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Settings")
                        .font(.system(size: 25))
                        .bold()
                    Spacer(minLength: 0)
                    Text("1.0.0 (1)")
                        .foregroundColor(Color("gray").opacity(0.7))
                }
                VStack(spacing:70){
                    HStack{
                        Image(systemName: "dollarsign.square")
                            .font(.system(size: 25))
                        Text("Currency")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        Spacer()
                        Text("LKR")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        
                    }
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(Color("gray1"))
                            .frame(height: 77)
                    )
                    
                    HStack{
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 25))
                        Text("Name")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        Spacer()
                        Text("Sanath")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        
                    }
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(Color("gray1"))
                            .frame(height: 77)
                    )
                }.padding(.top, 40)
                Spacer(minLength: 0)
            }
            NavigationLink(isActive: $isLogoutActive){
                StartUpView()
                    .navigationBarBackButtonHidden()
            } label: {

            }
        }.padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserViewModel())
    }
}
