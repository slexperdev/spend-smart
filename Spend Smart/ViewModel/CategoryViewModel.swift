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

    
    //Create new category
    func createCategory()  {
        self.isLoading = true
        guard let uid = Auth.auth().currentUser?.uid else { return }
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
        fetchCategories()
        self.isLoading = false
        
    }
    
    //Featch all categories
    func fetchCategories() {
        DispatchQueue.main.async {
         
            self.isLoading = true
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).collection("categories").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching categories: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            var fetchedCategories: [Category] = []
            
            for document in documents {
                let id = document.documentID
                if let categoryData = document.data() as? [String: Any],
                   let category = categoryData["category"] as? String,
                   let color = categoryData["color"] as? String {
                    let newCategory = Category(id: id, category: category, color: color)
                    fetchedCategories.append(newCategory)
                } else {
                    print("Failed to parse data for category with ID: \(id)")
                }
            }
            
            DispatchQueue.main.async {
                self.categories = fetchedCategories
                self.isLoading = false
            }
        }
    }

    
    //Cleare state
    func clearState(){
        self.color = ""
        self.category = ""
    }
}
