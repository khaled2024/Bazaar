//
//  subViews+Extension.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit
extension UIView{
    func addSubViews(_ views: [UIView]){
        for view in views{
            self.addSubview(view)
        }
    }
}
