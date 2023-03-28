//
//  SignInViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit

class SignInViewController: UIViewController{
    
    //MARK: - Proparties
    private let signInView = SignInView()
    private let authManager = AuthViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpiewController()
        setUpDelegation()
        setNavBar()
    }
    //MARK: - Proparties
    var email: String {
        signInView.emailTF.text ?? ""
    }
    var password: String{
        signInView.passwordTF.text ?? ""
    }
    //MARK: - Set Nav bar
    func setNavBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .label
    }
    // delegations
    func setUpDelegation(){
        signInView.delegate = self
        authManager.delegate = self
    }
    // Controllers
    func setUpiewController(){
        self.view = signInView
        view.backgroundColor = UIColor.backgroundColor
    }
}
//MARK: - signInViewDelegation
extension SignInViewController: signInViewDelegation {
    func signInView(_ view: SignInView, forgetPassTapped button: UIButton) {
        let forgetPassVC = ForgetPasswordViewController()
        //   forgetPassVC.modalPresentationStyle = .fullScreen
        //   self.present(forgetPassVC, animated: true)
        navigationController?.pushViewController(forgetPassVC, animated: true)
    }
    func signInView(_ view: SignInView, signInTapped button: UIButton) {
        print("Sign in :)")
        authManager.signIn(email: email, password: password)
    }
    func signInView(_ view: SignInView, signUpTapped button: UIButton) {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
//MARK: - AuthViewModelDelegation
extension SignInViewController: AuthViewModelDelegation{
    func errorHappen(error: Error) {
        Alert.alertMessage(title: "Error", message: error.localizedDescription, vc: self)
    }
    func signInSuccefully() {
        print("SignIn Succefully")
        // present MainRabbar
        let mainTabBar = MainTabBarController()
        mainTabBar.modalPresentationStyle = .fullScreen
        mainTabBar.modalTransitionStyle = .flipHorizontal
        self.present(mainTabBar, animated: true,completion: nil)
        // Reset Email & Password...
        signInView.emailTF.text = ""
        signInView.passwordTF.text = ""
    }
    func signUpSuccefully() {
        print("SignUp Succefully")
    }
}
