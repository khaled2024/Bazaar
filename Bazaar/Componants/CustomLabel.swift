//
//  CustomLabel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    convenience init(text: String, numberOfLines: Int,
                     font: String,size:CGFloat, textColor: UIColor,
                     textAlignment: NSTextAlignment,
                     isHidden: Bool? = nil) {
        self.init(frame: .zero)
        set(text: text, numberOfLines: numberOfLines, font: font,size: size, textColor: textColor, textAlignment: textAlignment, isHidden: isHidden)
    }
    func set(text: String, numberOfLines: Int,
             font: String,size: CGFloat, textColor: UIColor,
             textAlignment: NSTextAlignment,
             isHidden: Bool? = nil){
        self.text = text
        self.numberOfLines = numberOfLines
        self.font = UIFont(name: font, size: size)
        self.textColor = textColor
        self.textAlignment = textAlignment
        if let isHidden = isHidden{
            self.isHidden = isHidden
        }
    }
}

