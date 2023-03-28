//
//  CustomSearchViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 22/03/2023.
//

import UIKit
final class CustomSearchViewController: UISearchController{
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
        config()
    }
    func config(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    convenience init(searchPlaceholder: String? = nil,showBookmark: Bool? = nil) {
        self.init(searchResultsController: nil)
        set(searchPlaceholder: searchPlaceholder, showBookmark: showBookmark)
    }
    
    private func set(searchPlaceholder: String? = nil,showBookmark: Bool? = nil){
        if let searchPlaceholder = searchPlaceholder{
            searchBar.searchTextField.placeholder = searchPlaceholder
        }
        if let showBookmark = showBookmark{
            searchBar.showsBookmarkButton = showBookmark
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
