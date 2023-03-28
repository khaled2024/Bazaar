//
//  CustomPageController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit

class CustomPageController: UIPageControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(){
        currentPageIndicatorTintColor = .black
        pageIndicatorTintColor = .systemGray
    }
}
