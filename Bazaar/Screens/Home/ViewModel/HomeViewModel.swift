//
//  HomeViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 21/03/2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

protocol HomeViewModelDelegation: AnyObject{
    func getProfileURLSuccesfully(_ url: String)
    func getUserNameSuccesfully()
    func getCurrentHourSuccesfully()
}
final class HomeViewModel{
    //MARK: - Proparties
    private let currentUser = Auth.auth().currentUser
    private let storage = Storage.storage().reference()
    weak var delegate: HomeViewModelDelegation?
    var userName: String?
    var currentHour = NSDate().getCurrentHour()
    var morningText: String?

    //MARK: - Functions...
  
    //MARK: - get profile image...
    func getProfileImage(){
        if let currentUser = currentUser{
            let imageRef = storage.child("profileImages/file.png").child(currentUser.uid)
            imageRef.downloadURL {[weak self] url, error in
                guard let url = url else{return}
                let urlString = url.absoluteString
                self?.delegate?.getProfileURLSuccesfully(urlString)
            }
        }
    }
    //MARK: - Get user information
    func getUserInfo(){
        if let currentUser = currentUser{
            guard let userName = currentUser.displayName else{return}
            self.userName = userName
            delegate?.getUserNameSuccesfully()
        }
    }
    //MARK: - Change the current morning message
    func getTimeToChangeMorningMsg(){
        switch currentHour{
        case (6 ..< 12):
            morningText = "Good Morning ☀️"
            self.delegate?.getCurrentHourSuccesfully()
        case (12 ..< 16):
            morningText = "Good Afternoon 👋"
            self.delegate?.getCurrentHourSuccesfully()
            
        case (16 ..< 22):
            morningText = "Good Evening 👋"
            self.delegate?.getCurrentHourSuccesfully()
            
        case (0..<5):
            morningText = "Good Night 🌑"
            self.delegate?.getCurrentHourSuccesfully()
            
        default:
            morningText = "Good Night 🌑"
            self.delegate?.getCurrentHourSuccesfully()
        }
    }
}
