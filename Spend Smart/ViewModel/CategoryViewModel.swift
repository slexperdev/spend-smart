//
//  CategoryViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-24.
//

import Foundation
import Firebase

protocol CategoryFormProtocol {
    var formIsValid: Bool { get }
}

class CategoryViewModel : ObservableObject {
    @Published var isLoading : Bool =  false
    @Published var categories: [Category] = []
    @Published var color: String = ""
    @Published var category: String = ""
    @Published var totalExpense: Double = 0.0
    @Published var totalIncome: Double = 0.0
    @Published var colors = ["02B287", "D41F3A", "6E50FF", "35277F", "F39F2F", "26617F","808000","800080", "808080"]
    
    @Published var showAlert: Bool = false
    @Published var message: String = ""
    
    init(){
        Task{
            await fetchCategories()
        }
    }

    
    func createCategory() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.isLoading = true
        let db = Firestore.firestore()
        let doc = db.collection("users").document(uid).collection("categories")
        
         doc.addDocument(data: ["category": category, "color":color]) { error in
            if let error = error {
                self.showAlert = true
                self.message = "Error creating category: \(error)"
            } else {
                self.showAlert = true
                self.message = "Category successfully created!"
                self.clearState()
            }
        }
        await fetchCategories()
        self.isLoading = false
    }
    
    func fetchCategories() async{
        self.isLoading = true
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let querySnapshot = try? await Firestore.firestore().collection("users").document(uid).collection("categories").getDocuments() else { return }
        categories.removeAll()
        for document in querySnapshot.documents {
            if let categoryData = document.data() as? [String: Any],
               let category = categoryData["category"] as? String,
               let color = categoryData["color"] as? String {
                   let id = document.documentID
                   let newCategory = Category(id: id, category: category, color: color)
                   categories.append(newCategory)
            }
        }
        self.categories = categories
        self.isLoading = false
    }
    
    func clearState(){
        self.color = ""
        self.category = ""
    }
}
