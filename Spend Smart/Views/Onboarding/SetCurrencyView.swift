//
//  SetCurrencyView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-12.
//

import SwiftUI

struct SetCurrencyView: View {
    @StateObject var signUpVm : SignUpViewModel = SignUpViewModel()
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
                            Text("Sri Lanka Rupee").font(.system(size: 18))
                                .foregroundColor(.white)
                            Text("LKR").font(.system(size: 24)).bold()
                                .foregroundColor(.white)
                        }.padding(.horizontal, 20)
                    }
                }
                VStack{
                    InputView(text:$signUpVm.searchText, placeholder: "Search (USD, LKR, AUD, BTC, etc)")
                }
                Spacer()
                
                Button {
                   
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
            }
            
        }.padding()
            }
}

struct SetCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        SetCurrencyView()
    }
}
