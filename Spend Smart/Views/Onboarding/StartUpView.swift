//
//  StartUpView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-01.
//

import SwiftUI

struct StartUpView: View {
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment:.leading){
                VStack(alignment:.leading){
                    Image("applogo")
                    Text("SpendSmart").font(.system(size: 36)).bold()
                    Text("Your personal money manager").font(.system(size: 18))
                }
                VStack(spacing:20){
                    NavigationLink {
                        LoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .ignoresSafeArea(edges : .top)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(height: 60)
                            HStack{
                                Text("Exsiting account").font(.system(size: 16)).bold()
                                    .foregroundColor(.white)
                                Spacer()
                                Image("arrow")
                                    .padding(.horizontal)
                            }.padding(.horizontal)
                        }
                        
                    }
                    
                    NavigationLink {
                        CreateAccountView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .ignoresSafeArea(edges : .top)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(height: 60)
                            HStack{
                                Text("Create account").font(.system(size: 16)).bold()
                                    .foregroundColor(.white)
                                Spacer()
                                Image("arrow")
                                    .padding(.horizontal)
                            }.padding(.horizontal)
                        }
                        
                    }

                }.padding(.top, 100)
            }
        }.padding()
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpView()
    }
}
