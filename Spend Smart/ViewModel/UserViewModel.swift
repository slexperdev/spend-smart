//
//  LoginViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-08.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

class UserViewModel: ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var isAuthenticating: Bool = false
    @Published var showAlert: Bool = false
    @Published var message: String = ""
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var currency: String = "LKR"
    @Published var currencyName: String = "Sri Lanka Rupee"
    
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    //user login
    func signIn (withEmail email:String, password: String) async throws {
        DispatchQueue.main.async {
            self.isAuthenticating = true
        }
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            DispatchQueue.main.async {
                self.userSession = result.user
                self.isAuthenticated = true
            }
            
            UserDefaults.standard.set(true, forKey: "authenticated")
            await fetchUser()
        } catch{
            print("Failed to login with error \(error.localizedDescription)")
            self.showAlert = true
            self.message = "Invalid Credentials"
        }
        
        DispatchQueue.main.async {
            self.isAuthenticating = false
        }
    }
    
    //user register
    func signUp () async throws {
        DispatchQueue.main.async {
            self.isAuthenticating = true
        }
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
          
            DispatchQueue.main.async {
                self.userSession = result.user
            }
            let user = User(id:result.user.uid, fullname: fullName, email: email, currency: currency, currencyName:currencyName)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            DispatchQueue.main.async {
                self.isAuthenticated = true
            }
            UserDefaults.standard.set(self.isAuthenticated, forKey: "authenticated")
            
        } catch {
            print("Failed to create new user with error \(error.localizedDescription)")
        }
        DispatchQueue.main.async {
            self.isAuthenticating = false
        }
    }
    
    //user logout
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.isAuthenticated = false
            UserDefaults.standard.removeObject(forKey: "authenticated")
        } catch {
            print("Failed to create fetch user with error \(error.localizedDescription)")
        }
    }
    
    //user delete
    func deleteAccount(){
    }
    
    //get user
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snaphot  = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snaphot.data(as: User.self)
        
    }
    
}

