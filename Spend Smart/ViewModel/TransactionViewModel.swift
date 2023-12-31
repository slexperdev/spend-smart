//
//  ExpenseViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-28.
//

import Foundation
import Firebase

protocol TransactionFormProtocol {
    var formIsValid: Bool { get }
}

class TransactionViewModel : ObservableObject {
    @Published var isLoading : Bool =  false
    @Published var transactions: [Transaction] = []
    @Published var showAlert: Bool = false
    @Published var message: String = ""
    @Published var totalExpense: Double = 0.0
    @Published var totalIncome: Double = 0.0
    
    @Published var title: String = ""
    @Published var remark: String = ""
    @Published var selectedCategory: String = ""
    @Published var amount: String = ""
    @Published var createdOn = Date()
    
    init(){
        fetchTransactions()
        getTotalExpenseAndIncome()
    }
    
    //Create new Transaction (Expense and Income)
    func createTransaction(type: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let doc = db.collection("users").document(uid).collection("transactions")
        
        if let amountValue = Double(amount){
            let timestamp = Timestamp(date:createdOn)
        
            doc.addDocument(data: ["title":title, "remark": remark, "categoryId":selectedCategory, "amount": amountValue, "createdOn":timestamp, "type": type  ]) { error in
                if error != nil {
                    self.showAlert = true
                    self.message = "Error creating expense"
                } else {
                    self.showAlert = true
                    self.message = "Expense successfully created!"
                    self.clearState()
                    self.getTotalExpenseAndIncome()
                    self.fetchTransactions()
                }
            }
        } else {
            print("Invalid amount formate")
        }
            
        DispatchQueue.main.async {
            self.isLoading = false
            
        }
        
    }
    
    //Fetch all Transaction (Expense and Income)
    func fetchTransactions() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).collection("transactions").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching transactions: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            var fetchedTransactions: [Transaction] = []
            
            for document in documents {
                let id = document.documentID
                if let transactionData = document.data() as? [String: Any],
                   let title = transactionData["title"] as? String,
                   let type = transactionData["type"] as? String,
                   let remark = transactionData["remark"] as? String,
                   let amount = transactionData["amount"] as? Double,
                   let categoryId = transactionData["categoryId"] as? String,
                   let createdOnTimestamp = transactionData["createdOn"] as? Timestamp {
                    let createdOn = createdOnTimestamp.dateValue()
                    let newTransaction = Transaction(id: id, title: title, type: type, remark: remark, category: categoryId, amount: amount, createdOn: createdOn)
                    fetchedTransactions.append(newTransaction)
                } else {
                    print("Failed to parse data for document with ID: \(id)")
                }
            }
            
            DispatchQueue.main.async {
                self.transactions = fetchedTransactions
            }
        }
    }
    
    //Get total Transaction (Expense and Income)
    func getTotalExpenseAndIncome() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let transactionsCollection = db.collection("users").document(uid).collection("transactions")

        transactionsCollection
            .whereField("type", isEqualTo: "Expense") // Filter by type "Expense"
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching expenses: \(error)")
                } else if let querySnapshot = querySnapshot {
                    var totalExpense: Double = 0.0

                    for document in querySnapshot.documents {
                        if let amount = document.data()["amount"] as? Double {
                            totalExpense += amount
                        }
                    }

                    DispatchQueue.main.async {
                        self.totalExpense = totalExpense
                    }
                }
            }
        
        transactionsCollection
            .whereField("type", isEqualTo: "Income") // Filter by type "Income"
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching income: \(error)")
                } else if let querySnapshot = querySnapshot {
                    var totalIncome: Double = 0.0
                    
                    for document in querySnapshot.documents {
                        if let amount = document.data()["amount"] as? Double {
                            totalIncome += amount
                        }
                    }
                    DispatchQueue.main.async {
                        self.totalIncome = totalIncome
                    }
                }
            }
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    //Clear state
    func clearState(){
        self.title = ""
        self.remark = ""
        self.selectedCategory = ""
        self.amount = ""
    }
}
