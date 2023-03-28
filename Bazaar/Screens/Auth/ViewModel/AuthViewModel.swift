//
//  AuthViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.

import Foundation
import Firebase
import FirebaseFirestore

protocol AuthViewModelDelegation: AnyObject{
    func errorHappen(error:Error)
    func signInSuccefully()
    func signUpSuccefully()
}
final class AuthViewModel{
    weak var delegate: AuthViewModelDelegation?
    let database = Firestore.firestore()
    
    //MARK: - SignUp Method
    func signUp(username: String ,email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                self.delegate?.errorHappen(error: error)
                return
            }
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                if let error = error {
                    self.delegate?.errorHappen(error: error)
                    return
                }
            }
            guard let uid = authDataResult?.user.uid,
                  let email = authDataResult?.user.email else { return }
            let cart: [Int: Int] = [:]
            let wishList: [Int: Int] = [:]
            
            let user = User(id: uid, username: username, email: email, cart: cart, wishList: wishList)
            self.database.collection("Users").document(uid).setData(user.dictionary){error in
                if let error = error{
                    self.delegate?.errorHappen(error: error)
                    return
                }
                self.delegate?.signUpSuccefully()
            }
        }
    }
    //MARK: - SignIn Method
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            if let error = error {
                self.delegate?.errorHappen(error: error)
                return
            } else {
                self.delegate?.signInSuccefully()
            }
        }
    }
}
