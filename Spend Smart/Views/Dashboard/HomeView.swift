//
//  HomeView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userVm: UserViewModel
    @StateObject var transactionVm: TransactionViewModel = TransactionViewModel()
    
    @State var isNavigateToExpense: Bool = false
    @State var income: String = "Income"
    @State var expense: String = "Expense"
    
    @State private var isShowExpenseModel: Bool = false
    @State private var isShowIncomeModel: Bool = false
    
    var body: some View {
        ZStack{
            if userVm.isLoading {
                LoadingView()
            }
            VStack{
                HStack{
                    Text("Hi!")
                        .font(.system(size:28)).bold()
                    Text(userVm.currentUser?.fullname ?? "")
                        .font(.system(size:28))
                    Spacer(minLength: 0)

                }
                HStack{
                    Text(userVm.currentUser?.currency ?? "")
                        .font(.system(size:28))
                    Text((transactionVm.totalIncome - transactionVm.totalExpense).formattedPrice())
                        .font(.system(size:28))
                        .bold()
                    Spacer()
                }
                .padding(.top,5)
                
                
                Button{
                    isShowIncomeModel.toggle()
                } label: {
                    ZStack(alignment:.leading){
                        LinearGradient(colors: [Color("GradientStart"), Color("GradientEnd")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 18))
                            .frame(height: 102)
                        VStack(alignment:.leading, spacing: 20){
                            HStack{
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundColor(.white)
                                Text("Income").font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            Text("\(transactionVm.totalIncome.formattedPrice()) \(userVm.currentUser?.currency ?? "")").font(.system(size: 24)).bold()
                                .foregroundColor(.white)
                        }.padding(.horizontal, 20)
                    }
                }
                .sheet(isPresented: $isShowIncomeModel, onDismiss: {
                    isShowIncomeModel = false
                }){
                    AddTransactionView(type: $income)
                        .presentationDetents([.fraction(0.95)])
                        .presentationDragIndicator(.visible)
                }
                
                
                Button{
                    isShowExpenseModel.toggle()
                } label: {
                    ZStack(alignment:.leading){
                        LinearGradient(colors: [Color("GradientStart2"), Color("GradientEnd2")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges : .top).clipShape(RoundedRectangle(cornerRadius: 18))
                            .frame(height: 102)
                        VStack(alignment:.leading, spacing: 20){
                            HStack{
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.white)
                                Text("Expense").font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            Text("\(transactionVm.totalExpense.formattedPrice()) \(userVm.currentUser?.currency ?? "")").font(.system(size: 24)).bold()
                                .foregroundColor(.white)
                        }.padding(.horizontal, 20)
                    }
                }
                .sheet(isPresented:$isShowExpenseModel, onDismiss: {
                    isShowExpenseModel = false
                }){
                    AddTransactionView(type: $expense)
                        .presentationDetents([.fraction(0.95)])
                        .presentationDragIndicator(.visible)
                }
                
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color("gray0"))
                
                HStack{
                    Text("Transactions")
                        .font(.system(size: 20))
                        .bold()
                    Spacer()
                }.padding(.top)
                
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack(spacing:15){
                        ForEach(transactionVm.transactions, id:\.id){
                            transaction in
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("gray1"))
                                VStack(alignment:.leading, spacing:15){
                                    HStack{
                                        Text(transaction.title)
                                            .bold()
                                        Spacer()
                                        Text(transaction.createdOn.formatDate())
                                            .font(.system(size: 14))
                                    }
                                    Text(transaction.remark)
                                    
                                    HStack{
                                        Image(systemName: transaction.type == "Expense" ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                            .font(.system(size: 22))
                                            .foregroundColor(Color(transaction.type=="Expense" ? "GradientStart2" : "GradientStart"))
                                        Text(transaction.amount.formattedPrice())
                                            .foregroundColor(Color(transaction.type=="Expense" ? "GradientStart2" : "GradientStart"))
                                            .font(.system(size: 22))
                                            .bold()
                                        Text(userVm.currentUser?.currency ?? "")
                                            .foregroundColor(Color(transaction.type=="Expense" ? "GradientStart2" : "GradientStart"))
                                            .font(.system(size: 22))
                                        
                                    }
                                    
                                }.padding()
                            }
                        }
                    }
                }
            }.padding()
        }
        .onAppear{
            Task{
                await userVm.fetchUser()
                transactionVm.getTotalExpenseAndIncome()
                transactionVm.fetchTransactions()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserViewModel())
    }
}
