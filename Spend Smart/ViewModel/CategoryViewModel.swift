//
//  CategoryViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-24.
//

import Foundation
import Firebase

class CategoryViewMode : ObservableObject {
    @Published var isLoading : Bool =  false
    @Published var categories: [Category] = []
    
    init(){
        Task{
            await fetchCategories()
        }
    }

    
    func createCategory(category: String, color: String) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.isLoading = true
        let db = Firestore.firestore()
        let doc = db.collection("users").document(uid).collection("categories")
        
         doc.addDocument(data: ["category": category, "color":color]) { error in
            if let error = error {
                print("Error creating category: \(error)")
            } else {
                print("Category successfully created!")
            }
        }
        await fetchCategories()
        self.isLoading = false
    }
    
    func fetchCategories() async{
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
    }
}
