//
//  ProductsViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol ProductsViewModelDelegation: AnyObject {
    func errorHapped(_ error: Error)
    func didFetchSpecialProductsSuccessful()
    func didFetchCategoriesSuccessful()
    func didFetchAllProductsSuccessful()
    func didFetchProductsByCategorySuccessful()
    func didFetchSingleProductSuccessful(_ product: Product)
    func didUpdateWishListSuccessful()
}
final class ProductsViewModel{
    weak var delegate: ProductsViewModelDelegation?
    let service = Service.shared
    let currentUser = Auth.auth().currentUser
    let database = Firestore.firestore()
    
    //MARK: - Vars
    var specialsProducts: [Product] = []
    var allCategories = Categories()
    var productsByCategory: [Product] = []
    var singleProduct: Product?
    
    // deleted
    var wishList: [String: Int]? = [:]
    
    //MARK: - Functions
    // fetch all products
    func fetchAllProducts(){
        service.fetchProducts(type: .fetchAllProducts) {[weak self] products in
            if let products = products?.products{
                self?.productsByCategory = products
                self?.allProductsToFirestore(products: products)
                self?.delegate?.didFetchAllProductsSuccessful()
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
    }
    // fetchSpecialProducts
    func fetchSpecialProducts(){
        service.fetchProducts(type: .fetchAllProducts) { [weak self] productsResponse in
            if let products = productsResponse?.products{
                for _ in products {
                    let randomProduct = products.randomElement()
                    self?.specialsProducts.append(randomProduct!)
                }
                //   self?.specialsProducts = products
                self?.delegate?.didFetchSpecialProductsSuccessful()
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
    }
    // fetchAllCategories
    func fetchAllCategories(){
        service.fetchCategories(type: .fetchAllCategories) { [weak self] categories in
            if let categories = categories{
                self?.allCategories = categories
                self?.allCategories.insert("All", at:0)
                self?.delegate?.didFetchCategoriesSuccessful()
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
        
    }
    // fetchProductByCategory
    func fetchProductsByCategory(_ category: String){
        service.fetchProductByCategory(type: .fetchProductByCategory(category: category)) { [weak self] Response in
            if let products = Response?.products{
                self?.productsByCategory = products
                self?.delegate?.didFetchProductsByCategorySuccessful()
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
        
    }
    // fetch single product...
    func fetchSingleProduct(_ id: Int){
        service.fetchSingleProduct(type: .fetchSingleProduct(id: id)) {[weak self] product in
            if let product = product{
                self?.singleProduct = product
                self?.delegate?.didFetchSingleProductSuccessful(product)
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
        
    }
    // upload products to firebase
    func allProductsToFirestore(products: [Product]?) {
        guard let products = products else { return }
        products.forEach { product in
            guard let id = product.id else { return }
            database.collection("products").document("\(id)").setData(product.dictionary) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                }
            }
        }
    }
    
    
    // update firebase & wishlist vc when tapped on wishlist button...
    func updateWishList(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        if quantity > 0 {
            userRef.updateData(["wishList.\(productId)" : quantity]) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful()
                }
            }
        } else {
            userRef.updateData(["wishList.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful()
                }
            }
        }
    }
}
