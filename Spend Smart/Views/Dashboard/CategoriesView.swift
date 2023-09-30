//
//  CategoriesView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-17.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var userVm: UserViewModel
    @StateObject var categoryVm: CategoryViewModel = CategoryViewModel()
    
    
    @State private var isShowBottomSheet: Bool = false
    
    var body: some View {
        ZStack{
            if categoryVm.isLoading {
                LoadingView()
            }
            VStack{
                HStack{
                    Text("Categories")
                        .font(.system(size: 25))
                        .bold()
                    Spacer(minLength: 0)
                    Button{
                        isShowBottomSheet.toggle()
                    } label: {
                        ZStack{
                            LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top)
                                .clipShape(Circle())
                                .frame(width: 48,height: 48)
                            Image(systemName: "plus")
                                .foregroundColor(Color(.white))
                        }
                    }
                    .sheet(isPresented: $isShowBottomSheet){
                        bottomCardView
                            .presentationDetents([.fraction(0.6)])
                            .presentationDragIndicator(.visible)
                    }
                }
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack{
                        ForEach(categoryVm.categories, id: \.id) {
                            category in
                            ZStack(alignment:.leading){
                                RoundedRectangle(cornerRadius: 19)
                                    .foregroundColor(Color(hex: category.color))
                                    .frame(height: 80)
                                HStack{
                                    Image(systemName: "folder.circle")
                                        .foregroundColor(.white)
                                    Text(category.category).font(.system(size: 22))
                                        .foregroundColor(.white)
                                        .bold()
                                }.padding(.horizontal, 20)
                            }
                        }
                    }
                }
            }.padding()
        }.onAppear(perform:{
            Task{
                await categoryVm.fetchCategories()
            }
        })
    }
    //bottom sheet
    var bottomCardView:  some View {
        VStack(spacing:30){
            HStack{
                Text("Create new category")
                    .bold()
                    .font(.system(size: 22))
                Spacer()
            }.padding(.top, 10)
            HStack{
                Image(systemName: "pencil")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 20))
                TextField("Name", text: $categoryVm.category)
                    .font(.system(size: 20))
                    .padding(.horizontal, 5)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color("gray0")))
                Spacer()
            }
            HStack{
                Image(systemName: "checkmark")
                    .foregroundColor(Color("gray"))
                Text("Choose color")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 20))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoryVm.colors, id: \.self){
                        colorCode in
                        ZStack{
                            Circle()
                                .frame(height: 40)
                                .foregroundColor(Color(hex: colorCode))
                                .onTapGesture {
                                    categoryVm.color = colorCode
                                }
                            if categoryVm.color == colorCode {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("gray0"))
                            }
                        }
                    }
                }
            }
            Spacer()
            Button{
                
                categoryVm.createCategory()
                
            } label: {
                ZStack {
                    LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 33))
                        .frame(height: 54)
                    if categoryVm.isLoading {
                        ProgressView()
                    } else {
                        Text("Add")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.top)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .alert(isPresented: $categoryVm.showAlert) {
                Alert(title: Text("Category"), message: Text(categoryVm.message), dismissButton: .default(Text("OK")))
            }
            
            
        }.padding()
    }
}

//form validation
extension CategoriesView: CategoryFormProtocol {
    var formIsValid: Bool {
        return !categoryVm.color.isEmpty
        && !categoryVm.category.isEmpty
    }
}



struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(UserViewModel())
    }
}
