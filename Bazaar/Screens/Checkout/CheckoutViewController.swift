//
//  CheckoutViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 28/03/2023.
//

import UIKit

class CheckoutViewController: UIViewController {

    //MARK: - Properties
    
     let checkoutView = CheckoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    

    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        view = checkoutView
    }
}
