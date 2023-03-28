//
//  CustomSearchBar.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 22/03/2023.
//

import UIKit

final class CustomSearchBar: UISearchBar{
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(showBookmarkBtn: Bool? = nil,placeholder: String? = nil,bacgroundColor: UIColor? = nil){
        self.init(frame: .zero)
        set(showBookmarkBtn: showBookmarkBtn, placeholder: placeholder,bacgroundColor: bacgroundColor)
    }
    
    func set(showBookmarkBtn: Bool? = nil,placeholder: String? = nil,bacgroundColor: UIColor? = nil){
        if let  showBookmarkBtn = showBookmarkBtn{
            self.showsBookmarkButton = showBookmarkBtn
        }
        if let placeholder = placeholder{
            self.searchTextField.placeholder = placeholder
        }
        if let bacgroundColor = bacgroundColor{
            self.barTintColor = bacgroundColor
        }
    }
}
