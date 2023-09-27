//
//  HomeView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userVm: UserViewModel
    
    var body: some View {
        if let user = userVm.currentUser {
            VStack(){
                HStack{
                    Text("Hi!")
                        .font(.system(size:28)).bold()
                    Text(user.fullname)
                        .font(.system(size:28))
                    Spacer(minLength: 0)
                    
                }
                HStack{
                    Text(user.currency)
                        .font(.system(size:28)).bold()
                    Text("0")
                        .font(.system(size:28))
                        .bold()
                    Text(".00") .font(.system(size:20))
                    Spacer(minLength: 0)
                }
                .padding(.top,5)
                VStack{
                    VStack{
                        ZStack(alignment:.leading){
                            LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 18))
                                .frame(height: 102)
                            VStack(alignment:.leading, spacing: 20){
                                HStack{
                                    Image("download")
                                    Text("Income").font(.system(size: 18))
                                        .foregroundColor(.white)
                                }
                                Text("0.00 \(user.currency)").font(.system(size: 24)).bold()
                                    .foregroundColor(.white)
                            }.padding(.horizontal, 20)
                        }
                    }
                    VStack{
                        ZStack(alignment:.leading){
                            LinearGradient(colors: [Color("GradientStart2"), Color("GradientEnd2")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 18))
                                .frame(height: 102)
                            VStack(alignment:.leading, spacing: 20){
                                HStack{
                                    Image("upload")
                                    Text("Expense").font(.system(size: 18))
                                        .foregroundColor(.white)
                                }
                                Text("0.00 \(user.currency)").font(.system(size: 24)).bold()
                                    .foregroundColor(.white)
                            }.padding(.horizontal, 20)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserViewModel())
    }
}
