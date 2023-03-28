//
//  ProductDetailViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol ProductDetailViewModelProtocol: AnyObject {
    func errorHapped(_ error: Error)
    func didUpdatewishlistSuccessfully(productId: Int)
    func didUpdateCartSuccessful(quantity: Int)
    func didFetchCartCountSuccessfully()
    func didFetchCartCostSuccessful(productId: Int, quantity: Int)
    
}
final class ProductDetailViewModel{
    weak var delegate: ProductDetailViewModelProtocol?
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    var wishList: [String: Int]? = [:]
    var cartlist: [String: Int]? = [:]
    var cartCost: Double?
    
    
    //MARK: - Fetch wishlist
    func fetchWishlist(productID: Int){
        guard let currentUser = currentUser else{return}
        let wishlistRef = database.collection("Users").document(currentUser.uid)
        wishlistRef.getDocument(source: .default) { documentData, error in
            guard let documentData = documentData else{return}
            self.wishList = documentData.get("wishList")as? [String:Int]
            if let wishlist = self.wishList{
                for (id,_) in wishlist{
                    if id == String(productID){
                        self.delegate?.didUpdatewishlistSuccessfully(productId: productID)
                    }else{
                        print("error didnt find the wishlist product for \(productID) wishlist have \(wishlist.count)")
                    }
                }
                
            }
        }
    }
    //MARK: -  fetch Cart list
    
    // to firebase...
    // and the productID and the quantity to firbase ex:- [10 : 1]
    func updateCart(productid: Int,quantity: Int){
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        if quantity > 0{
            userRef.updateData(["cart.\(productid)" : quantity]) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful(quantity: quantity)
                }
            }
        }else{
            userRef.updateData(["cart.\(productid)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful(quantity: 0)
                }
            }
        }
    }
    // here we take the items from the cart in firebase... ex:- [1 : 3, 4 : 5 , 22 : 7 ]
    func fetchCart(productId: Int){
        guard let currentUser = currentUser else{return}
        let cartRef = database.collection("Users").document(currentUser.uid)
        cartRef.getDocument(source: .default) { documentData, error in
            guard let documentData = documentData else{return}
            self.cartlist = documentData.get("cart") as? [String: Int]
            print(self.cartlist ?? "no cart list")
            self.delegate?.didFetchCartCountSuccessfully()
            if let cartlist = self.cartlist{
                self.fetchProductCostInCart(productId: productId, cart: cartlist)
            }
        }
    }
    // ex we need to get price of product id (1) has 3 quantity :-
    // 1. search in products in firebase and get quantity
    // 2. get the price of product and * quantity the store in cartCost :---
    func fetchProductCostInCart(productId: Int, cart: [String: Int]) {
        let productsRef = database.collection("products")
        let product = productsRef.document("\(productId)")
        
        if let quantity = cart["\(productId)"] {
            product.getDocument { documentData, error in
                guard let documentData = documentData else { return }
                guard let price = documentData.get("price") as? Double else { return }
                let roundedCost = Double(price * Double(quantity)).rounded(toPlaces: 2)
                self.cartCost = roundedCost
                self.delegate?.didFetchCartCostSuccessful(productId: productId, quantity: quantity)
            }
        } else {
            product.getDocument { documentData, error in
                guard let documentData = documentData else { return }
                guard let price = documentData.get("price") as? Double else { return }
                let cost = Double(price * Double(1))
                self.cartCost = cost
                self.delegate?.didFetchCartCostSuccessful(productId: productId, quantity:0)
            }
        }
    }
}
