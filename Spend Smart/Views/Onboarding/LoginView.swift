//
//  LoginView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-08.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userVm: UserViewModel
    @Environment(\.presentationMode) var present
    
    @State private var email: String = ""
    @State private var password: String = ""
        
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
                
                Image("applogo")
                Text("SpendSmart").font(.system(size: 36)).bold()
               
                Text("Your personal money manager").font(.system(size: 18))
                VStack(spacing: 30){
                    InputView(text: $email, placeholder: "Email address")
                    InputView(text: $password, placeholder: "Password", isSecured: true)
                    Button {
                        Task{
                            try await userVm.signIn(withEmail:email, password:password)
                        }
                    } label: {
                        ZStack {
                            LinearGradient(colors: [Color("GradientStart1"), Color("GradientEnd1")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 33))
                                .frame(height: 54)
                            HStack{
                                Spacer()
                                if userVm.isAuthenticating {
                                    ProgressView()
                                        .foregroundColor(.white)
                                } else {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                Spacer()
                                Image("arrow")
                            }.padding(.horizontal, 20)
                        }
                    }
                }.padding(.vertical, 80)
            }
            NavigationLink(isActive: $userVm.isAuthenticated){
                DashboardView()
                    .navigationBarBackButtonHidden()
            } label: {

            }
        }.padding()
        Spacer()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserViewModel())
    }
}
