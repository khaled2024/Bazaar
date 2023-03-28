//
//  ProfileViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 19/03/2023.

import UIKit

class ProfileViewController: UIViewController{
    //MARK: - Proparties...
    private let profileView = ProfileView()
    private let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        profileViewModel.fetchProfilePhoto()
        profileViewModel.fetchUser()
        setNavBar()
    }
    //MARK: - functions...
    func setupDelegates(){
        profileView.interface = self
        profileViewModel.delegate = self
        view = profileView
    }
    func setNavBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .label
    }
}
//MARK: - ProfileViewInterface
extension ProfileViewController: ProfileViewInterface{
    func uploadProfileImageButton(_ view: ProfileView,_ button: UIButton) {
        // Image Picker Controller...
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func TappedLogout(_ view: ProfileView,_ button: UIButton) {
        profileViewModel.SuccessfullyLogout()
    }
    func changePasswordButton(_ view: ProfileView,_ button: UIButton) {
        let changePasswordVC = ForgetPasswordViewController()
        //        changePasswordVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(changePasswordVC, animated: true)
        //        self.present(changePasswordVC, animated: true)
    }
}
//MARK: - ProfileViewModelDelegate
extension ProfileViewController: ProfileViewModelDelegate{
    func didFetchUserInfo() {
        guard let userName = profileViewModel.userName,let email = profileViewModel.email else{return}
        // put the name & email in the TF..
        profileView.configUserInfo(userName, email: email)
    }
    func errorHapped(_ error: Error) {
        Alert.alertMessage(title: "Error!", message: "Error when Account Logout:(", vc: self)
    }
    func Logout() {
        print("Log out Successfuly :)")
        let signInVC = SignInViewController()
        let signInNC = UINavigationController(rootViewController: signInVC)
        signInNC.modalTransitionStyle = .flipHorizontal
        signInNC.modalPresentationStyle = .fullScreen
        self.present(signInNC, animated: true)
//        navigationController?.dismiss(animated: true)
    }
    func imageUploadedSuccessuly() {
        profileViewModel.fetchProfilePhoto()
    }
    func didFetchProfilePhotoSuccessful(_ url: String) {
        // put the image in the profileImageView...
        profileView.profileImage.downloadSetImage(urlString: url)
        profileView.actvityIndecator.stopAnimating()
    }
    
}
//MARK: - Picker image controller
extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Take the image
        // make an func in VM to take the image and upload it to firebase...
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage]as? UIImage else{return}
        guard let imageData = image.pngData() else{return}
        profileViewModel.uploadProfileImageToFirebase(imageData)
        profileView.actvityIndecator.startAnimating()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

