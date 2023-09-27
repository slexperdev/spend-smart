//
//  CategoriesView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-17.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var userVm: UserViewModel
    @StateObject var categoryVm: CategoryViewMode = CategoryViewMode()
    
    @State private var isShowBottomSheet: Bool = false
    @State private var category: String = ""
    @State private var color: String = ""
    
    let colors = ["02B287", "D41F3A", "6E50FF", "35277F", "F39F2F", "26617F"]
    
    var body: some View {
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
                        .presentationDetents([.medium, .medium])
                        .presentationDragIndicator(.visible)
                }
            }
            ScrollView{
                VStack{
                    ForEach(categoryVm.categories, id: \.id) {
                        category in
                        ZStack(alignment:.leading){
                            RoundedRectangle(cornerRadius: 19)
                                .foregroundColor(Color(hex: category.color))
                                .frame(height: 150)
                            VStack(alignment:.leading, spacing: 20){
                                HStack{
                                    Image(systemName: "bag")
                                        .foregroundColor(.white)
                                    Text(category.category).font(.system(size: 22))
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                HStack{
                                    Text("Total Income")
                                        .font(.system(size: 18))
                                            .foregroundColor(.white)
                                    Spacer()
                                    Text("Total Expense")
                                        .font(.system(size: 18))
                                            .foregroundColor(.white)
                                }
                                HStack{
                                    Text("0.00 LKR")
                                        .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    Spacer()
                                    Text("0.00 LKR")
                                        .font(.system(size: 16))
                                            .foregroundColor(.white)
                                }
            
                            }.padding(.horizontal, 20)
                        }

                    }
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding()
        
    }
    var bottomCardView:  some View {
        VStack{
            HStack{
                Text("Create new category")
                    .bold()
                    .font(.system(size: 22))
                Spacer()
            }.padding(.top, 10)
            HStack{
                Text("Choose color :")
                    .font(.system(size: 18))
                Spacer()
            }.padding(.top)
            ScrollView(.horizontal){
                HStack{
                    ForEach(colors, id: \.self){
                        colorCode in
                        Circle()
                            .frame(height: 40)
                            .foregroundColor(Color(hex: colorCode))
                            .onTapGesture {
                                color = colorCode
                            }
                    }
                }
            }.padding(.top)
            HStack{
                Text("Category name :")
                    .font(.system(size: 18))
                Spacer()
            }.padding(.top)
            HStack{
                TextField("Eg: foods & drinks, Bills & fees", text:$category)
                    .padding(.horizontal, 5)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                Spacer()
            }.padding(.top)
            
            Spacer()
            Button{
                Task {
                    try await categoryVm.createCategory(category: category, color: color)
                }
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
            }.padding(.top)
            
        }.padding()
    }
}




struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(UserViewModel())
    }
}
