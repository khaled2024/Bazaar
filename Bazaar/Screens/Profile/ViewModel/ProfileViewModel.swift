//
//  ProfileViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 20/03/2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

protocol ProfileViewModelDelegate: AnyObject {
    func Logout()
    func errorHapped(_ error: Error)
    func imageUploadedSuccessuly()
    func didFetchProfilePhotoSuccessful(_ url: String)
    func didFetchUserInfo()
}
final class ProfileViewModel{
    weak var delegate: ProfileViewModelDelegate?
    private let currentUser = Auth.auth().currentUser
    private let storage = Storage.storage().reference()
    
    var userName: String?
    var email: String?
    //MARK: - Functions
    func SuccessfullyLogout(){
        do{
            try Auth.auth().signOut()
            delegate?.Logout()
        }catch{
            delegate?.errorHapped(error)
        }
    }
    func fetchUser(){
        if let currentUser = currentUser{
            self.userName = currentUser.displayName
            self.email = currentUser.email
            delegate?.didFetchUserInfo()
        }
    }
    func uploadProfileImageToFirebase(_ imageData: Data){
        if let currentUser = currentUser{
            let profileImageRef = storage.child("profileImages/file.png").child(currentUser.uid)
            profileImageRef.putData(imageData){storageData,error in
                guard error == nil else{return}
                self.delegate?.imageUploadedSuccessuly()
            }
        }
    }
    func fetchProfilePhoto(){
        if let currentUser = currentUser{
            let profileImageRef = storage.child("profileImages/file.png").child(currentUser.uid)
            profileImageRef.downloadURL { url, error in
                guard let url = url,error == nil else{return}
                let urlString = url.absoluteString
                self.delegate?.didFetchProfilePhotoSuccessful(urlString)
                print("Fetching Profile image Successfuly :)")
            }
        }
    }
}
