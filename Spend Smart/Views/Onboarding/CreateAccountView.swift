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
                    ZStack(alignment: .trailing){
                        InputView(text: $userVm.password, placeholder: "Password", isSecured: true)
                        if !userVm.password.isEmpty{
                            if userVm.password.count > 5 {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.green)
                                    .padding(.trailing)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.red)
                                    .padding(.trailing)
                            }
                        }
                    }
                    ZStack (alignment: .trailing){
                        InputView(text: $userVm.confirmPassword, placeholder: "Confirm password", isSecured: true)
                        
                        if !userVm.password.isEmpty && !userVm.confirmPassword.isEmpty {
                            if userVm.password == userVm.confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.green)
                                    .padding(.trailing)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.red)
                                    .padding(.trailing)
                            }
                        }
                    }
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
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    
                }.padding(.vertical, 80)
            }
           
        }.padding()
        Spacer()
    }
}

extension CreateAccountView: AuthenticationFormProtocol {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    var formIsValid: Bool {
        return Self.isValidEmail(userVm.email)
        && !userVm.fullName.isEmpty
        && !userVm.password.isEmpty
        && !userVm.confirmPassword.isEmpty
        && userVm.password.count > 5
        && userVm.password == userVm.confirmPassword
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(UserViewModel())
    }
}
