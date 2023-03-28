//
//  WishlistViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 26/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

protocol WishlistViewModelDelegate: AnyObject {
    func errorHappen(error: Error)
    func emprtyProductsMessage(error: String)
    func didFetchProductsFromWishListSuccessful()
    func didFetchSingleProduct(_ product: Product)
    func didUpdateWishListSuccessful()
}

final class WishlistViewModel{
    
    private let currentUser = Auth.auth().currentUser
    private let database = Firestore.firestore()
    
    weak var delegate: WishlistViewModelDelegate?
    var singleProduct: Product?
    let manager = Service.shared
    var wishListProducts: [Product] = []
    
    var wishList: [String: Int]? = [:] {
        didSet {
            guard let wishList = wishList else { return }
            if wishList.isEmpty == true {
                delegate?.emprtyProductsMessage(error: "No Products Please add some wishList Products:)")
            } else {
                fetchProductFromFireStoreCollection(wishList: wishList)
            }
        }
    }
    
    //MARK: - Get Wishlist from Firestore
    
    func fetchWishList() {
        guard let currentUser = currentUser else { return }
        
        let wishListRef = database.collection("Users").document(currentUser.uid)
        wishListRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.wishList = documentData.get("wishList") as? [String: Int]
            }
        }
    }
    
    //MARK: - Fetch Product From FirestoreCollection to wishListProducts
    
    func fetchProductFromFireStoreCollection(wishList: [String: Int]) {
        let productsRef = database.collection("products")
        
        for (id, _) in wishList {
            let product = productsRef.document(id)
            product.getDocument(as: Product.self) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.errorHappen(error: error)
                case .success(let product):
                    guard let productId = product.id else { return }
                    if !self.wishListProducts.contains(where: { product in
                        return product.id == productId
                    }) {
                        self.wishListProducts.append(product)
                    }
                    print("wishlist products is : \(self.wishListProducts)")
                    self.delegate?.didFetchProductsFromWishListSuccessful()
                }
            }
        }
    }
    //MARK: - FetchSingleProduct
    
    func fetchSingleProduct(_ productId: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProduct(id: productId)) { product in
            if let product = product {
                self.singleProduct = product
                self.delegate?.didFetchSingleProduct(product)
            }
        } onError: { error in
            self.delegate?.errorHappen(error: error)
        }
        
    }
    //MARK: - GetProductIndexPath
    
    func getProductIndexPath(productId: Int) -> IndexPath {
        let index = wishListProducts.firstIndex { product in
            product.id == productId
        }
        if let index = index {
            return IndexPath(row: index, section: 0)
        }
        return IndexPath()
    }
    //MARK: - RemoveProduct
    
    func removeProduct(index: Int) {
        wishListProducts.remove(at: index)
    }
    
    //MARK: - Update WishList in Firestore
    
    func updateWishList(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        
        if quantity > 0 {
            userRef.updateData(["wishList.\(productId)" : quantity]) { error in
                if let error = error {
                    self.delegate?.errorHappen(error: error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful()
                }
            }
        } else {
            userRef.updateData(["wishList.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.errorHappen(error: error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful()
                }
            }
        }
    }
}
