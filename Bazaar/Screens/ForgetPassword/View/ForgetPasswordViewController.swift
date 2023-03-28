//
//  ForgetPasswordViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    //MARK: - Proparties...
    private let viewModel = ForgetPasswordViewModel()
    private let forgetPassView = ForgetPasswordView()
    
    var email: String{
        forgetPassView.emailTF.text ?? ""
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forget Password"
        self.view = forgetPassView
        setUpDelegate()
        setUpNavBar()
    }
    //MARK: - functions:
    func setUpDelegate(){
        forgetPassView.interface = self
        viewModel.delegate = self        
    }
    func setUpNavBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .label
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.label]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
}
//MARK: - Interface delegate
extension ForgetPasswordViewController: ForgetPasswordViewInterface{
    func resetPasswordTapped(_ btton: UIButton) {
        viewModel.resetPassword(email)
    }
}
//MARK: - Delegate for viewModel
extension ForgetPasswordViewController: ForgetPasswordDelegation{
    func sendEmailSuccessufly() {
        Alert.alertMessage(title: "Successful!", message: "A password reset email has been sent!", vc: self)
    }
    func errorHapped(_ error: Error) {
        Alert.alertMessage(title: "Sorry!", message: error.localizedDescription, vc: self)
    }
}
