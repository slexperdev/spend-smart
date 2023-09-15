//
//  LoginView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-08.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVm : LoginViewModel = LoginViewModel()
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
                
                Image("applogo")
                Text("SpendSmart").font(.system(size: 36)).bold()
                Text("Your personal money manager").font(.system(size: 18))
                VStack(spacing: 30){
                    InputView(text: $loginVm.email, placeholder: "Email address")
                    InputView(text: $loginVm.password, placeholder: "Password", isSecured: true)
                    Button {
                       
                    } label: {
                        ZStack {
                            LinearGradient(colors: [Color("GradientStart1"), Color("GradientEnd1")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 33))
                                .frame(height: 54)
                            HStack{
                                Spacer()
                                Text("Login")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
