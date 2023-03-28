//
//  MainTabBarController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.
//

import UIKit
import Firebase
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    //MARK: - functions
    func setUpTabBar(){
        let viewControllers = [homeVC(),searchVC(),cartVC(),profileVC()]
        setViewControllers(viewControllers, animated: true)
        tabBar.tintColor = .label
        tabBar.itemPositioning = .centered
        UITabBar.appearance().barTintColor = .backgroundColor
//        self.tabBar.isTranslucent = false
    }
    // homeVC
    private func homeVC()-> UINavigationController{
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return UINavigationController(rootViewController: homeVC)
    }
    //searchVC
    private func searchVC()-> UINavigationController{
        let searchVC = SearchController()
        searchVC.title = "Search"
        searchVC.view.backgroundColor = .backgroundColor
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        return UINavigationController(rootViewController: searchVC)
    }
    //profileVC
    private func profileVC()-> UINavigationController{
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        profileVC.view.backgroundColor = .backgroundColor
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        return UINavigationController(rootViewController: profileVC)
    }
    // CartVC
    private func cartVC()-> UINavigationController{
        let cartVC = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        return UINavigationController(rootViewController: cartVC)
    }
}
