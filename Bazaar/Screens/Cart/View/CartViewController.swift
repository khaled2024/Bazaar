//
//  CartViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 19/03/2023.
//

import UIKit

class CartViewController: UIViewController {
    
    deinit {
        print("CartController deinit")
    }
    private let cartView = CartView()
    private let cartViewModel = CartViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setNavBar()
        setupDelegate()
        registerCells()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cartViewModel.fetchCart()
        cartView.priceLabel.text = "$\(cartViewModel.totalCost)"
    }
    
    //MARK: - function...
    func setupDelegate(){
        cartView.cartCollectionView.delegate = self
        cartView.cartCollectionView.dataSource = self
        cartView.interface = self
        cartViewModel.delegate = self
    }
    func setUpView(){
        navigationItem.title = "Cart"
        view = cartView
        view.backgroundColor = .backgroundColor
    }
    func setNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem?.tintColor = .label
    }
    func registerCells(){
        cartView.cartCollectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
    }
}
//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension CartViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.cartProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartView.cartCollectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath)as? CartCollectionViewCell else{
            return UICollectionViewCell()
        }
        let product = cartViewModel.cartProducts[indexPath.row]
        cell.interface = self
        if let productID = product.id{
            if let quantity = cartViewModel.cart?["\(productID)"]{
                cell.quantity = quantity
            }
        }
        cell.config(cartProduct: product)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = cartViewModel.cartProducts[indexPath.row].id else { return }
        cartViewModel.fetchSingleProduct(productId)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartView.cartCollectionView.frame.width - 10, height: 130)
    }
}
//MARK: - Cart View model delegate
extension CartViewController: CartViewModelDelegate{
    // for error handeling
    func errorHapped(_ error: Error) {
        print(error.localizedDescription)
    }
    // for if there is no products in cart...
    func emprtyProductsMessage(error: String) {
        Alert.alertMessage(title: "Error❌", message: error, vc: self)
        cartView.cartCollectionView.isHidden = true
        cartView.cartEmptyImage.isHidden = false
    }
    // for getting Number of cart in cart list from firebase...
    func didFetchCartCountSuccessful() {
        if let cartCount = cartViewModel.cart?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
    }
    // getting products from firebase
    func didFetchProductsFromCartSuccessful() {
        DispatchQueue.main.async { [weak self] in
            self?.cartView.cartCollectionView.reloadData()
        }
        // for image empty
        cartView.cartCollectionView.isHidden = false
        cartView.cartEmptyImage.isHidden = true
    }
    // for updating (+ , - button or remove btn)...
    func didUpdateCartSuccessful() {
        cartViewModel.fetchCart()
    }
    // get the total cost
    func didFetchCostAccToItemCount() {
        cartView.priceLabel.text = "$\(cartViewModel.totalCost)"
    }
    // fetch single roduct by the id
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailViewController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    // when checkout the cart
    func didCheckoutSuccessful() {
        let checkoutVC = CheckoutViewController()
        checkoutVC.modalPresentationStyle = .custom
        checkoutVC.transitioningDelegate = self
        self.present(checkoutVC, animated: true, completion: nil)
    }
    // when didnt checkout the cart
    func didCheckoutNotSuccessful() {
        let checkoutVC = CheckoutViewController()
        checkoutVC.modalPresentationStyle = .custom
        checkoutVC.transitioningDelegate = self
        checkoutVC.checkoutView.configure()
        self.present(checkoutVC, animated: true, completion: nil)
    }
    
}

//MARK: - CartCollectionCellInterface

extension CartViewController: CartCollectionCellInterface {
    func cartCollectionCell(_ view: CartCollectionViewCell, productId: Int, stepperValueChanged quantity: Int, _ button: UIButton) {
        if quantity == 0 {
            let indexPath = cartViewModel.getProductIndexPath(productId: productId)
            cartViewModel.removeProduct(index: indexPath.row, productId: String(productId))
            cartView.cartCollectionView.deleteItems(at: [indexPath])
        }
        cartViewModel.updateCart(productId: productId, quantity: quantity)
    }
    
    func cartCollectionCell(_ view: CartCollectionViewCell, productId: Int, removeButtonTapped quantity: Int, _ button: UIButton) {
        let indextPath = cartViewModel.getProductIndexPath(productId: productId)
        cartViewModel.removeProduct(index: indextPath.row, productId: String(productId))
        cartView.cartCollectionView.deleteItems(at: [indextPath])
        cartViewModel.updateCart(productId: productId, quantity: 0)
    }
}
//MARK: - Cart view inteface
extension CartViewController: CartViewInterface{
    func cartView(_ view: CartView, checkoutButtonTapped button: UIButton) {
        cartViewModel.checkout()
    }
}

//MARK: - Custom Presentation Controller

extension CartViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
