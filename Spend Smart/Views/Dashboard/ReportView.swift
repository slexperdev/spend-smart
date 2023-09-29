//
//  ReportView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-29.
//

import SwiftUI

struct ReportView: View {
    @EnvironmentObject var userVm: UserViewModel
    @StateObject var reportVm: ReportViewModel = ReportViewModel()
    @StateObject var transactionVm: TransactionViewModel = TransactionViewModel()
    
    @State private var tabIndex:Int = 0
    
    var filteredTransactions: [Transaction] {
           let currentDate = Date()
           switch tabIndex {
           case 1:
               return transactionVm.transactions.filter {
                   Calendar.current.isDate($0.createdOn, inSameDayAs: currentDate)
               }
           case 2:
               let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
               let endOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startOfWeek)!
               return transactionVm.transactions.filter {
                   $0.createdOn >= startOfWeek && $0.createdOn < endOfWeek
               }
           case 3:
               let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate))!
               let endOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)!
               return transactionVm.transactions.filter {
                   $0.createdOn >= startOfMonth && $0.createdOn < endOfMonth
               }
           default:
               return []
           }
       }

    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:0){
                            Text("Summery")
                                .foregroundColor(self.tabIndex == 0 ? .white : .black.opacity(0.7))
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 35)
                                .background(Color("green").opacity(self.tabIndex == 0 ? 1: 0)
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    self.tabIndex = 0
                                }
                            Spacer(minLength: 0)
                            Text("Day")
                                .foregroundColor(self.tabIndex == 1 ? .white : .black.opacity(0.7))
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 35)
                                .background(Color("green").opacity(self.tabIndex == 1 ? 1: 0)
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    self.tabIndex = 1
                                }
                            Spacer(minLength: 0)
                            Text("Week")
                                .foregroundColor(self.tabIndex == 2 ? .white : .black.opacity(0.7))
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 35)
                                .background(Color("green").opacity(self.tabIndex == 2 ? 1: 0)
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    self.tabIndex = 2
                                }
                            Spacer(minLength: 0)
                            Text("Month")
                                .foregroundColor(self.tabIndex == 3 ? .white : .black.opacity(0.7))
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 35)
                                .background(Color("green").opacity(self.tabIndex == 3 ? 1: 0)
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    self.tabIndex = 3
                                }
                            
                        }
                    }
                    
                }
                .background(Color.black.opacity(0.06))
                .clipShape(Capsule())
                ScrollView(.vertical,showsIndicators: false){
                    LazyVStack(spacing:10){
                        if tabIndex == 0 {
                            ForEach(reportVm.reports, id: \.id) {
                                category in
                                ZStack(alignment:.leading){
                                    RoundedRectangle(cornerRadius: 19)
                                        .foregroundColor(Color(hex: category.color))
                                        .frame(height: 150)
                                    VStack(alignment:.leading, spacing: 20){
                                        HStack{
                                            Image(systemName: "folder.circle")
                                                .foregroundColor(.white)
                                            Text(category.category).font(.system(size: 22))
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                        HStack{
                                            Text("Total Income")
                                                .bold()
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                                
                                            Spacer()
                                            Text("Total Expense")
                                                .bold()
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                        }
                                        HStack{
                                            Image(systemName: "arrow.down")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16))
                                            Text("\(category.totalIncome.formattedPrice()) \(userVm.currentUser!.currency)")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                            Spacer()
                                            Image(systemName: "arrow.up")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16))
                                            Text("\(category.totalExpense.formattedPrice()) \(userVm.currentUser!.currency)")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                        }
                                        
                                    }.padding(.horizontal, 20)
                                }
                                
                            }
                        } else {
                            ForEach(filteredTransactions, id:\.id){
                                transaction in
                                VStack(spacing:15){
                                    HStack{
                                        //                                Image(systemName: "pencil")
                                        Text(transaction.title)
                                            .bold()
                                        Spacer()
                                        Text(transaction.createdOn.formatDate())
                                            .font(.system(size: 14))
                                        
                                    }
                                    HStack{
                                        Text(transaction.remark)
                                        Spacer()
                                    }
                                    HStack{
                                        Image(systemName: transaction.type == "Expense" ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                            .font(.system(size: 22))
                                            .foregroundColor(Color(transaction.type=="Expense" ? "GradientStart2" : "GradientStart"))
                                        Text(transaction.amount.formattedPrice())
                                            .foregroundColor(Color(transaction.type=="Expense" ? "GradientStart2" : "GradientStart"))
                                            .font(.system(size: 22))
                                            .bold()
                                        Text(userVm.currentUser!.currency)
                                            .foregroundColor(Color(transaction.type=="Expense" ? "GradientStart2" : "GradientStart"))
                                            .font(.system(size: 22))
                                        Spacer()
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color("gray1"))
                                )
                            }

                        }
                    }
                }.padding(.top)
                
                Spacer(minLength: 0)
            }
            .padding(.top)
            .padding(.horizontal)
            
            if reportVm.isLoading{
                LoadingView()
            }

        }.onAppear(perform: {
            Task{
                await reportVm.fetchReports()
                transactionVm.fetchTransactions()
            }
        })
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
            .environmentObject(UserViewModel())
    }
}
