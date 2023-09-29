//
//  ReportViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-29.
//

import Foundation
import Firebase

class ReportViewModel : ObservableObject {
    @Published var isLoading : Bool =  false
    @Published var reports: [Report] = []
    
    init(){
        Task{
            await fetchReports()
        }
    }
    
    func fetchReports() async {
           guard let uid = Auth.auth().currentUser?.uid else { return }
           self.isLoading = true
           do {
               // Fetch categories
               let categorySnapshot = try await Firestore.firestore()
                   .collection("users")
                   .document(uid)
                   .collection("categories")
                   .getDocuments()
               
               var updatedReports: [Report] = []
               
               for categoryDocument in categorySnapshot.documents {
                   if let categoryData = categoryDocument.data() as? [String: Any],
                      let category = categoryData["category"] as? String,
                      let color = categoryData["color"] as? String,
                      let categoryId = categoryDocument.documentID as? String {
                       
                       // Fetch expenses for the current category
                       let expenseSnapshot = try await Firestore.firestore()
                           .collection("users")
                           .document(uid)
                           .collection("transactions")
                           .whereField("categoryId", isEqualTo: categoryId)
                           .whereField("type", isEqualTo: "Expense")
                           .getDocuments()
                       
                       // Calculate the total expense
                       let totalExpense = expenseSnapshot.documents
                           .compactMap { $0.data()["amount"] as? Double }
                           .reduce(0.0, +)
                       
                       // Fetch incomes for the current category
                       let incomeSnapshot = try await Firestore.firestore()
                           .collection("users")
                           .document(uid)
                           .collection("transactions")
                           .whereField("categoryId", isEqualTo: categoryId)
                           .whereField("type", isEqualTo: "Income")
                           .getDocuments()
                       
                       // Calculate the total income
                       let totalIncome = incomeSnapshot.documents
                           .compactMap { $0.data()["amount"] as? Double }
                           .reduce(0.0, +)
                       
                       // Create the updated Category model with totals
                       let updatedReport = Report(id: categoryId, category: category, color: color, totalIncome: totalIncome, totalExpense: totalExpense)
                       
                       updatedReports.append(updatedReport)
                   }
               }
               
               self.reports = updatedReports
               self.isLoading = false
           } catch {
               print("Error fetching data: \(error.localizedDescription)")
               self.isLoading = false

           }
       }
    
    
}
