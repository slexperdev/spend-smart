//
//  AddExpenseView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-20.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var present
    @EnvironmentObject var userVm: UserViewModel
    @Binding var type: String
    
    @StateObject var categoryVm: CategoryViewModel = CategoryViewModel()
    @StateObject var transactionVm: TransactionViewModel = TransactionViewModel()
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 40){
                HStack{
                    Image(systemName: type == "Expense" ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                    Text(type)
                        .font(.system(size: 20))
                        .bold()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("gray1"))
                        .frame(height: 40)
                )
                HStack{
                    Image(systemName: "pencil")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 20))
                    TextField("Title", text: $transactionVm.title)
                        .font(.system(size: 20))
                        .padding(.horizontal, 5)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color("gray0")))
                }
                HStack{
                    Image(systemName: "message")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 20))
                    TextField("Remark", text: $transactionVm.remark)
                        .font(.system(size: 20))
                        .padding(.horizontal, 5)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color("gray0")))
                }
                HStack{
                    Image(systemName: "folder")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 20))
                    Text("Category")
                        .foregroundColor(Color("gray"))
                    HStack{
                        Picker("", selection: $transactionVm.selectedCategory){
                            ForEach(categoryVm.categories, id: \.id){
                                category in
                                Text(category.category)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("gray1"))
                            .frame(height: 35)
                    )
                    Spacer()
                }
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 20))
                    Text("Created on")
                        .foregroundColor(Color("gray"))
                    DatePicker("", selection: $transactionVm.createdOn)
                }
                VStack{
                    TextField("0.00", text: $transactionVm.amount )
                        .font(.system(size: 36))
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    if let user = userVm.currentUser {
                        Text("Amount (\(user.currency))")
                            .font(.system(size: 20))
                            .foregroundColor(Color("gray"))
                    }
                }
                Button{
                    Task{
                        try await transactionVm.createTransaction(type: type)
                    }
                } label: {
                    ZStack {
                        LinearGradient(colors: [Color(type == "Expense" ? "GradientStart2" : "GradientStart"), Color(type == "Expense" ? "GradientEnd2" : "GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 33))
                            .frame(height: 54)
                        if transactionVm.isLoading {
                            ProgressView()
                        } else {
                            Text("Add")
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .alert(isPresented: $transactionVm.showAlert) {
                        Alert(title: Text("Expense"), message: Text(transactionVm.message), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
            }
            
        }
        .padding()
    }
}

//form validation
extension AddTransactionView: CategoryFormProtocol {
    var formIsValid: Bool {
        return !transactionVm.title.isEmpty
        && !transactionVm.remark.isEmpty
        && !transactionVm.selectedCategory.isEmpty
        && !transactionVm.amount.isEmpty
    }
}



struct AddExpenseView_Previews: PreviewProvider {
    @State static var type: String = ""
    
    static var previews: some View {
        AddTransactionView(type: $type)
            .environmentObject(UserViewModel())
    }
}
