//
//  SignInView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.
//

import UIKit
protocol signInViewDelegation: AnyObject {
    func signInView(_ view: SignInView,forgetPassTapped button: UIButton)
    func signInView(_ view: SignInView,signInTapped button: UIButton)
    func signInView(_ view: SignInView,signUpTapped button: UIButton)
}
final class SignInView: UIView{
    
    weak var delegate: signInViewDelegation?
    //MARK: - creating ui elements...
    private var signInLbl = CustomLabel(text: "SignIn", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 45, textColor: .label, textAlignment: .left)
    private var welcomeLbl = CustomLabel(text: "Welcome👋🏼", numberOfLines: 0, font: FiraSana.medium.rawValue, size: 20, textColor: .gray, textAlignment: .left)
    var emailTF = CustomTextField(isSecureTextEntry: false, attributedPlaceholder: NSAttributedString(string: "Enter your Email",attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]), image: UIImage(named: "email")!)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10, isHidden: false)
    var passwordTF = CustomTextField(isSecureTextEntry: true, attributedPlaceholder: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(named: "lock")!)
    private var textFieldStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 25, isHidden: false)
    private var signInButton = CustomButton(title: "Sign In", titleColor: .white, font: UIFont(name: FiraSana.bold.rawValue, size: 19), backgroundColor: .black, cornerRadius: 20)
    private var forgotPasswordButton = CustomButton(title: "Forgot your password?", titleColor: .myYellow, font: UIFont(name: FiraSana.bold.rawValue, size: 15))
    private var signUpLabel = CustomLabel(text: "Don't have an account?", numberOfLines: 1, font: FiraSana.regular.rawValue, size: 18, textColor: .systemGray, textAlignment: .center)
    private var signUpButton = CustomButton(title: "Sign Up", titleColor: .myYellow, font: UIFont(name: FiraSana.bold.rawValue, size: 15), cornerRadius: 20)
    private var signUpStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 10, isHidden: false)
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addTarget()
        addSubviews()
        addLabelsToStackView()
        addTextFieldsToStackView()
        addSignUpElementsToStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addTarget(){
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    @objc private func forgotPasswordButtonTapped(_ button: UIButton) {
        delegate?.signInView(self, forgetPassTapped: button)
    }
    
    @objc private func signInButtonTapped(_ button: UIButton) {
        delegate?.signInView(self, signInTapped: button)
    }
    @objc private func signUpButtonTapped(_ button: UIButton) {
        delegate?.signInView(self, signUpTapped: button)
    }
}
//MARK: - UI Elements AddSubiew / Constraints
extension SignInView {
    //MARK: - Addsubview
    private func addSubviews() {
        addSubViews([labelStackView, textFieldStackView, signInButton, forgotPasswordButton, signUpStackView])
    }
    private func addLabelsToStackView() {
        labelStackView.addArrangedSubviews([signInLbl, welcomeLbl])
    }
    private func addTextFieldsToStackView() {
        textFieldStackView.addArrangedSubviews([emailTF, passwordTF])
    }
    private func addSignUpElementsToStackView() {
        signUpStackView.addArrangedSubviews([signUpLabel, signUpButton])
    }
    //MARK: - Setup Constraints
    private func setupConstraints() {
        labelStackViewConstraints()
        textFieldStackViewConstraints()
        forgotPasswordButtonConstraints()
        emailTextFieldConstraints()
        signInButtonConstraints()
        signUpStackViewConstraints()
    }
    private func labelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    private func emailTextFieldConstraints() {
        emailTF.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.06)
        }
    }
    private func textFieldStackViewConstraints() {
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(35)
            make.leading.equalTo(labelStackView.snp.leading)
            make.trailing.equalTo(labelStackView.snp.trailing)
        }
    }
    private func forgotPasswordButtonConstraints() {
        forgotPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(15)
            make.trailing.equalTo(textFieldStackView.snp.trailing)
        }
    }
    private func signInButtonConstraints() {
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(35)
            make.leading.trailing.equalTo(textFieldStackView)
            make.height.equalTo(56)
        }
    }
    
    private func signUpStackViewConstraints() {
        signUpStackView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(25)
            make.centerX.equalTo(textFieldStackView.snp.centerX)
        }
    }
}

