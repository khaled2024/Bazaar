//
//  CustomTextField.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.
//

import UIKit
final class CustomTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(){
        autocapitalizationType = .none
        textColor = .black
        backgroundColor = .white
        leftViewMode = .always
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        setupSmartTF()
    }
    convenience init(isSecureTextEntry: Bool? = nil,attributedPlaceholder: NSAttributedString, image: UIImage){
        self.init(frame: .zero)
        set(isSecureTextEntry: isSecureTextEntry, attributedPlaceholder: attributedPlaceholder, image: image)
    }
    private func setupSmartTF(){
        smartDashesType = .no
        smartQuotesType = .no
        smartInsertDeleteType = .no
        spellCheckingType = .no
        autocorrectionType = .no
    }
    private func set(isSecureTextEntry: Bool? = nil ,attributedPlaceholder: NSAttributedString, image: UIImage) {
        
        self.attributedPlaceholder = attributedPlaceholder
        // iconImage...
        let imageView = UIImageView(frame: CGRect(x: 5, y: 8, width: 25, height: 25))
         let image = image
        imageView.image = image
        let viewLeft: UIView = UIView(frame: CGRectMake(10, 0, 40, 40))// set per your requirement
        viewLeft.addSubview(imageView)
        leftView = viewLeft
        leftViewMode = .always
        if let isSecureTextEntry = isSecureTextEntry {
            self.isSecureTextEntry = isSecureTextEntry
        }
    }
}






