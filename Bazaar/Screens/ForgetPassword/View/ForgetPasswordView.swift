//
//  ForgetPasswordView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 19/03/2023.
//

import UIKit
import SnapKit

protocol ForgetPasswordViewInterface: AnyObject {
    func resetPasswordTapped(_ btton: UIButton)
}
final class ForgetPasswordView: UIView{
    weak var interface: ForgetPasswordViewInterface?
    //MARK: - Ui elements:)
    
    private var titleLbl = CustomLabel(text: "Send a password to reset email.", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 30, textColor: .label, textAlignment: .left)
    var emailTF = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(named: "email")!)
    private var resetPassBtn = CustomButton(title: "Reset Password", titleColor: .white, font: UIFont(name: FiraSana.bold.rawValue, size: 16),backgroundColor: .black,cornerRadius: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addTarget()
        setUpLayout()
        setUpConstrains()
        
    }
    private func addTarget(){
        resetPassBtn.addTarget(self, action: #selector(resetPassTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func resetPassTapped(_ button: UIButton){
        interface?.resetPasswordTapped(button)
    }
    
}
//MARK: - Constrains
extension ForgetPasswordView{
    private func setUpLayout(){
        addSubViews([titleLbl,resetPassBtn,emailTF])
    }
    private func setUpConstrains(){
        // titleLabel..
        titleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-200)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        // email TF
        emailTF.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.06)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-100)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        // reset password
        resetPassBtn.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(emailTF.snp.bottom).offset(35)
            make.centerX.equalTo(emailTF.snp.centerX)
            make.width.equalTo(emailTF).multipliedBy(0.5)
        }
    }
}


