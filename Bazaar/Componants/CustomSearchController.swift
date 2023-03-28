//
//  CustomSearchController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 28/03/2023.
//

import Foundation

import UIKit

class CustomSearchController: UISearchController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
        configure()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(searchPlaceHolder: String, showsBookmarkButton: Bool) {
        self.init(searchResultsController: nil)
        set(searchPlaceHolder: searchPlaceHolder, showsBookmarkButton: showsBookmarkButton)
    }
    

    private func configure() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(searchPlaceHolder: String, showsBookmarkButton: Bool) {
        searchBar.searchTextField.placeholder = searchPlaceHolder
        searchBar.showsBookmarkButton = showsBookmarkButton
    }

}
