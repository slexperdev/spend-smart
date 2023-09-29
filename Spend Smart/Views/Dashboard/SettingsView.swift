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
    @State private var isShowDeleteModal = false
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea(edges : .top)
            VStack{
                HStack{
                    Text("Settings")
                        .font(.system(size: 25))
                        .bold()
                    Spacer(minLength: 0)
                    Text("1.0.0 (1)")
                        .foregroundColor(Color("gray").opacity(0.7))
                }
                VStack(alignment: .leading, spacing:20){
                    Text("Account")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("gray"))
                        .padding(.leading)
                    ZStack{
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(Color("gray1"))
                            .frame(height: 60)
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 25))
                            Text("Name")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                            Spacer()
                            Text(userVm.currentUser?.fullname ?? "")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(Color("gray1"))
                            .frame(height: 60)
                        HStack{
                            Image(systemName: "dollarsign.square")
                                .font(.system(size: 25))
                            Text("Currency")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                            Spacer()
                            Text(userVm.currentUser?.currency ?? "")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal)
                    }
                    
                }.padding(.top)
                Spacer(minLength: 0)
                VStack(alignment: .leading, spacing:20){
                    Text("Danger zone")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("red"))
                        .padding(.leading)
                    ZStack{
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(Color("orange"))
                            .frame(height: 60)
                        HStack{
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            Text("Logout")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }.onTapGesture {
                        
                        userVm.signOut()
                        isLogoutActive = true
                        
                    }
                    Button {
                        isShowDeleteModal.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(Color("red"))
                                .frame(height: 60)
                            HStack{
                                Image(systemName: "trash")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                Text("Delete account")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }.sheet(isPresented: $isShowDeleteModal){
                        VStack(spacing: 10){
                            HStack{
                                Text("Delete user ?")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("red"))
                                Spacer(minLength: 0)
                            }
                            HStack{
                                Text("Warning! This acction will delete your account permenently and you won't be able to recover it.")
                                    .font(.system(size: 18))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("gray"))
                                Spacer(minLength: 0)
                            }
                            
                            HStack{
                                
                                Spacer()
                                
                                Button{
                                    isShowDeleteModal = false
                                    userVm.deleteAccount()
                                    isLogoutActive = true
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius:50)
                                            .foregroundColor(Color("red"))
                                            .frame(width:130, height: 50)
                                        HStack{
                                            Image(systemName: "trash")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                            Text("Delete")
                                                .font(.system(size: 20))
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                            
                            Spacer(minLength: 0)
                        }.padding()
                            .presentationDetents([.fraction(0.3)])
                    }
                }
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
