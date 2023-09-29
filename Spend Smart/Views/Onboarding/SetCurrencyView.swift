//
//  SetCurrencyView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-12.
//

import SwiftUI

struct SetCurrencyView: View {
    @EnvironmentObject var userVm : UserViewModel
    @StateObject var currencyVm: CurrencyViewModel = CurrencyViewModel()
    
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
                
                Text("Set currency").font(.system(size: 36)).bold()
                    .padding(.top, 20)
                VStack{
                    ZStack(alignment:.leading){
                        LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 18))
                            .frame(height: 102)
                        VStack(alignment:.leading, spacing: 20){
                            Text(userVm.currencyName).font(.system(size: 18))
                                .foregroundColor(.white)
                            Text(userVm.currency).font(.system(size: 24)).bold()
                                .foregroundColor(.white)
                        }.padding(.horizontal, 20)
                    }
                }
                VStack{
                    InputView(text:$currencyVm.searchText, placeholder: "Search (USD, LKR, AUD, BTC, etc)")
                }
                ScrollView{
                    VStack{
                        ForEach(currencyVm.getFilteredCurrencies(), id: \.code){
                            currency in
                            ZStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(height: 85)
                                    .foregroundColor(Color("gray0"))
                                HStack{
                                    Text(currency.code)
                                        .bold()
                                    Text(currency.name)
                                }.padding(.horizontal)
                            }
                            .onTapGesture {
                                userVm.currency = currency.code
                                userVm.currencyName = currency.name
                            }
                        }
                    }.padding(.top)
                }
                Spacer()
                
                Button {
                    Task{
                        try await userVm.signUp()
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
                                Text("Finish")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            Spacer()
                            Image("arrow")
                        }.padding(.horizontal, 20)
                    }
                    
                }
            }
            NavigationLink(isActive: $userVm.isAuthenticated){
                DashboardView()
                    .navigationBarBackButtonHidden()
            } label: {
                
            }
        }.padding()
    }
}

struct SetCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        SetCurrencyView()
            .environmentObject(UserViewModel())
    }
}
