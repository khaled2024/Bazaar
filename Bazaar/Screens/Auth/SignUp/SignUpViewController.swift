//
//  SignUpViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    private let authViewModel = AuthViewModel()
    private let signUpView = SignUpView()
    
    //MARK: - Gettable Properties
    var username: String {
        guard let username = signUpView.usernameTextField.text else { return ""}
        return username
    }
    var email: String {
        guard let email = signUpView.emailTextField.text else { return ""}
        return email
    }
    var password: String {
        guard let password = signUpView.passwordTextField.text else { return ""}
        return password
    }
    var confirmPassword: String {
        guard let confirmPassword = signUpView.confirmPasswordTextField.text else { return ""}
        return confirmPassword
    }
    //MARK: - ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegates()
        configureNavBar()
    }
    //MARK: - Configure ViewController
    private func configureViewController() {
        view = signUpView
    }
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .label
    }
    private func setupDelegates() {
        signUpView.delegate = self
        authViewModel.delegate = self
    }
    //MARK: - CheckPasswordMatch
    private func checkPasswordMatch() -> Bool {
        return password == confirmPassword
    }
    private func checkTextFields()-> Bool{
        if username.isEmpty || email.isEmpty {
            return false
        }else{
            return true
        }
    }
}
//MARK: - SignUpViewDelegation
extension SignUpViewController: SignUpViewDelegation {
    func signUpView(_ view: SignUpView, signUpButtonTapped button: UIButton) {
        guard checkPasswordMatch() == true else {
            Alert.alertMessage(title: "Passwords do not match.", message: "", vc: self); return }
        guard checkTextFields() == true else{
            Alert.alertMessage(title: "Please fill all fields.", message: "", vc: self); return }
        // here if check goes true he create the account and go to AuthViewModel
        authViewModel.signUp(username: username, email: email, password: password)
    }
    func signUpView(_ view: SignUpView, signInButtonTapped button: UIButton) {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
//MARK: - AuthViewModelDelegation
extension SignUpViewController: AuthViewModelDelegation {
    func errorHappen(error: Error) {
        Alert.alertMessage(title: "\(error.localizedDescription)", message: "", vc: self)
    }
    func signInSuccefully() {
        print("sign in successful")
    }
    func signUpSuccefully() {
        Alert.alertMessageWithCompletion(title: "Congratulation", message: "Account Created Successfully🥳", vc: self, preferredStyle: .alert) { _ in
            let signInVC = SignInViewController()
            self.navigationController?.pushViewController(signInVC, animated: true)
        }
    }
}
