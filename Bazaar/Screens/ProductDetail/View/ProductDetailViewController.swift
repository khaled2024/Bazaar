//
//  ProductDetailViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import UIKit

class ProductDetailViewController: UIViewController {
    let productsViewModel = ProductsViewModel()
    let productDetailView = ProductDetailView()
    let productDetailViewModel = ProductDetailViewModel()
    var product: Product
    
    let wishlistViewModel = WishlistViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view = productDetailView
        productDetailView.config(product: product)
        productDetailView.interface = self
        productDetailViewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .label
        if let productID = product.id{
            productDetailViewModel.fetchCart(productId: productID)
            productDetailViewModel.fetchWishlist(productID: productID)
        }
    }
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -  functions...
    private func configureNavBar() {
        navigationItem.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem?.tintColor = .label
    }
}
//MARK: -  ProductDetailViewInterface
extension ProductDetailViewController: ProductDetailViewInterface{
    // cart func
    func AddToCartButton(_ view: ProductDetailView, addToCartButtonTapped button: UIButton, quantity: Int) {
        guard let productID = product.id else{return}
        // here we take the productID and quantity of the item...
        productDetailViewModel.updateCart(productid: productID,quantity: quantity)
    }
    func productDetailView(_ view: ProductDetailView, stepperValueChanged quantity: Int) {
        guard let productID = product.id else{return}
        productDetailViewModel.updateCart(productid: productID,quantity: quantity)
    }
    // wishlist func
    func AddToWishlistTappedBtn(_ view: ProductDetailView, button addToWishButton: UIButton, quantity: Int) {
        guard let productID = product.id else{return}
        productsViewModel.updateWishList(productId: productID, quantity: quantity)
    }
}
//MARK: - ProductDetailViewDeleagte
extension ProductDetailViewController: ProductDetailViewModelProtocol{
    func errorHapped(_ error: Error) {
        print(error.localizedDescription)
    }
    // Cart list
    // 1
    func didUpdateCartSuccessful(quantity: Int) {
        if let productid = product.id{
            productDetailViewModel.fetchCart(productId: productid)
        }
    }
    // 2
    func didFetchCartCountSuccessfully() {
        if let cartCount = productDetailViewModel.cartlist?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
    }
    // 3
    func didFetchCartCostSuccessful(productId: Int, quantity: Int) {
        if let cost = productDetailViewModel.cartCost {
            productDetailView.priceLabel.text = "$\(cost)"
            productDetailView.stepperStackView.isHidden = false
            productDetailView.quantityLabel.isHidden = false
            productDetailView.quantity = quantity
        } else {
            productDetailView.stepperStackView.isHidden = true
            productDetailView.quantityLabel.isHidden = true
        }
    }
  
    // wishlist
    func didUpdatewishlistSuccessfully(productId: Int) {
        if productId == product.id{
            productDetailView.addToWishListButton.isSelected = true
        }else{
            productDetailView.addToWishListButton.isSelected = false
        }
    }
}
