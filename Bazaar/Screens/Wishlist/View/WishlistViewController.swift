//
//  WishlistViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 22/03/2023.
//

import UIKit

class WishlistViewController: UIViewController {
    
    private let wishlistView = WishlistView()
    private let wishlistViewModel = WishlistViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavbar()
        registerCell()
        setupDelegate()
        wishlistViewModel.fetchWishList()
    }
    
    //MARK: - function
    func setUpView(){
        view.backgroundColor = .backgroundColor
        navigationItem.title = "Wishlist"
        view = wishlistView
    }
    func setUpNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem?.tintColor = .label
    }
    func registerCell(){
        wishlistView.wishlistCollection.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
    func setupDelegate(){
        wishlistView.wishlistCollection.delegate = self
        wishlistView.wishlistCollection.dataSource = self
        
        wishlistViewModel.delegate = self
    }
}
//MARK: - UICollectionViewDelegate,UICollectionViewDataSource...
extension WishlistViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlistViewModel.wishListProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath)as? ProductCollectionViewCell else{return UICollectionViewCell()}
        cell.wishlistBtn.isHidden = false
        cell.wishlistBtn.isSelected = true
        cell.interface = self
        cell.configCell(wishlistViewModel.wishListProducts[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: wishlistView.wishlistCollection.frame.width/2 - 10, height: wishlistView.wishlistCollection.frame.width/1.6)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productID = wishlistViewModel.wishListProducts[indexPath.row].id else{return}
        wishlistViewModel.fetchSingleProduct(productID)
    }
    
}
//MARK: - WishlistViewModelDelegate
extension WishlistViewController: WishlistViewModelDelegate{
  
    func errorHappen(error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchProductsFromWishListSuccessful() {
        DispatchQueue.main.async { [weak self] in
            self?.wishlistView.wishlistCollection.isHidden = false
            self?.wishlistView.wishlistEmptyImage.isHidden = true
            self?.wishlistView.wishlistCollection.reloadData()
        }
    }
    // single product
    func didFetchSingleProduct(_ product: Product) {
        let detailProductVC = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailProductVC, animated: true)
    }
    // update product wishlist when want to delete it...
    func didUpdateWishListSuccessful() {
        wishlistViewModel.fetchWishList()
    }
    
    func emprtyProductsMessage(error: String) {
        Alert.alertMessage(title: "Error❌", message: error, vc: self)
        wishlistView.wishlistCollection.isHidden = true
        wishlistView.wishlistEmptyImage.isHidden = false
    }
    
   
   
}
//MARK: - ProductsCollectionViewCellInterface
extension WishlistViewController: ProductsCollectionViewCellInterface{
    func productCollectionCell(_ view: ProductCollectionViewCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        // do something...
        let productIndex = wishlistViewModel.getProductIndexPath(productId: productId)
        wishlistViewModel.removeProduct(index: productIndex.row)
        wishlistView.wishlistCollection.deleteItems(at: [productIndex])
        wishlistViewModel.updateWishList(productId: productId, quantity: 0)
    }
}
