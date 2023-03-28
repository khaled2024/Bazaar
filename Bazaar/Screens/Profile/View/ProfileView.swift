//
//  ProfileView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 20/03/2023.
//

import UIKit
import SnapKit

protocol ProfileViewInterface: AnyObject{
    func TappedLogout(_ view: ProfileView,_ button: UIButton)
    func uploadProfileImageButton(_ view: ProfileView,_ button: UIButton)
    func changePasswordButton(_ view: ProfileView,_ button: UIButton)
}
final class ProfileView: UIView{
    //MARK: - proparties:-
    weak var interface: ProfileViewInterface?
    //MARK: - Ui elements
    private var logOutButton = CustomButton(title: "Logout", titleColor: .white, font: UIFont(name: FiraSana.bold.rawValue, size: 20),backgroundColor: .systemRed,cornerRadius: 16)
    private var uploadProfileImageButton = CustomButton(title: "Upload Profile image",titleColor: .white, font: UIFont(name: FiraSana.bold.rawValue, size: 16),backgroundColor: .black,cornerRadius: 20)
    private var changePassButton = CustomButton(title: "Change password",titleColor: .white, font: UIFont(name: FiraSana.bold.rawValue, size: 16),backgroundColor: .myYellow,cornerRadius: 20)
    var profileImage = CustomImageView(image: UIImage(named: "person"), tintColor: .white, bacgroundColor: .backgroundColor, contentMode: .scaleToFill, maskToBound: true, cornerRadius: 75, isUserInteractionEnabled: false)
    var userNameLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 20, textColor: .label, textAlignment: .left)
    var emailLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 18, textColor: .label, textAlignment: .left)
    var actvityIndecator: UIActivityIndicatorView = {
        let Indecator = UIActivityIndicatorView(style: .large)
        Indecator.color = .white
        return Indecator
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTargetButton()
        setUpViews()
        setUpConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions...
    func setUpTargetButton(){
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        uploadProfileImageButton.addTarget(self, action: #selector(uploadProfileImageTapped), for: .touchUpInside)
        changePassButton.addTarget(self, action: #selector(changePassTapped), for: .touchUpInside)
    }
    // for config userInfo...
    func configUserInfo(_ userName: String,email: String){
        print(userName)
        print(email)
        userNameLbl.text = userName
        emailLbl.text = email
        self.profileImage.image = UIImage(named: "person")
    }
    @objc func logOutTapped(_ button: UIButton){
        interface?.TappedLogout(self, button)
    }
    @objc func uploadProfileImageTapped(_ button: UIButton){
        interface?.uploadProfileImageButton(self, button)
    }
    @objc func changePassTapped(_ button: UIButton){
        interface?.changePasswordButton(self, button)
    }
}
//MARK: - Constrains
extension ProfileView{
    func setUpViews(){
        addSubViews([logOutButton,profileImage,uploadProfileImageButton,changePassButton,userNameLbl,emailLbl,actvityIndecator])
    }
    func setUpConstrains(){
        // Name
        userNameLbl.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(profileImage.snp.bottom).offset(20)
        }
        // Email
        emailLbl.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(userNameLbl.snp.bottom).offset(20)
        }
        // profileImage
        profileImage.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        // logOut button...
        logOutButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        // uploadProfileImageButton
        uploadProfileImageButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(logOutButton.snp.top).offset(-10)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        // changePassButton
        changePassButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(uploadProfileImageButton.snp.top).offset(-10)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        // actvityIndecator
        actvityIndecator.snp.makeConstraints { make in
            make.centerX.equalTo(profileImage.snp.centerX)
            make.centerY.equalTo(profileImage.snp.centerY)
        }
    }
    
}
