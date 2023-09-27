//
//  CreateAccountView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-08.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var userVm: UserViewModel
    
    @Environment(\.presentationMode) var present
    
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment:.leading){
               
                Button(action: {present.wrappedValue.dismiss()}){
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                Spacer()
                
                Text("Create Account").font(.system(size: 36)).bold()
                Text("Elevate Your Financial Game with SpendSmart.").font(.system(size: 14)).foregroundColor(Color("gray"))
                VStack(spacing: 30){
                    InputView(text: $userVm.fullName, placeholder: "Display name")
                    InputView(text: $userVm.email, placeholder: "Email address")
                    InputView(text: $userVm.password, placeholder: "Password", isSecured: true)
                    InputView(text: $userVm.confirmPassword, placeholder: "Confirm password", isSecured: true)
                    NavigationLink {
                        SetCurrencyView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            LinearGradient(colors: [Color("GradientStart1"), Color("GradientEnd1")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 33))
                                .frame(height: 54)
                            HStack{
                                Spacer()
                                Text("Next")
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                                Image("arrow")
                            }.padding(.horizontal, 20)
                        }
                        
                    }
                    
                }.padding(.vertical, 80)
            }
           
        }.padding()
        Spacer()
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(UserViewModel())
    }
}
