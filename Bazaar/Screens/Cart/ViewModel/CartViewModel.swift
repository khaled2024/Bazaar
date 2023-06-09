//
//  CartViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 27/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol CartViewModelDelegate: AnyObject {
    func errorHapped(_ error: Error)
    
    func didUpdateCartSuccessful()
    func didFetchProductsFromCartSuccessful()
    func didFetchCartCountSuccessful()
    func didFetchSingleProduct(_ product: Product)
    func didFetchCostAccToItemCount()
    func emprtyProductsMessage(error: String)
    
    func didCheckoutSuccessful()
    func didCheckoutNotSuccessful()
}
final class CartViewModel{
    //MARK: - Proparties...
    let manager = Service.shared
    weak var delegate: CartViewModelDelegate?
    private var database = Firestore.firestore()
    private var currentUser = Auth.auth().currentUser
    var singleProduct: Product?
    var cartProducts: [Product] = []{
        didSet{
            if cartProducts.count == cart?.count{
                self.delegate?.didFetchProductsFromCartSuccessful()
            }
        }
    }
    
    var cart: [String:Int]? = [:]{
        didSet{
            guard let cart = cart else{return}
            if cart.isEmpty == true{
                // empty logic
                costAccToItemCount = [:]
                cartProducts = []
                self.delegate?.emprtyProductsMessage(error: "No Products! Please add some Products to your Cart 😁")
            }else{
                fetchProductFromFirestoreCollection(cart: cart)
                fetchCostAccToCount(cart: cart)
            }
        }
    }
    var costAccToItemCount: [String: Double] = [:] {
        didSet {
            if costAccToItemCount.count == cart?.count {
                delegate?.didFetchCostAccToItemCount()
                
            }
        }
    }
    
    //MARK: - Get Cart from Firestore
    // 1.
    func fetchCart() {
        guard let currentUser = currentUser else { return }
        let cartRef = database.collection("Users").document(currentUser.uid)
        cartRef.getDocument(source: .default) {[weak self] documentData, error in
            if let documentData = documentData {
                self?.cart = documentData.get("cart") as? [String : Int]
                self?.delegate?.didFetchCartCountSuccessful()
            }
        }
    }
    //MARK: - Fetch Product From FirestoreCollection to cartsProducts
    // 2.
    func fetchProductFromFirestoreCollection(cart: [String:Int]) {
        let productsRef = database.collection("products")
        for (id, _) in cart {
            let product = productsRef.document(id)
            product.getDocument(as: Product.self) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.errorHapped(error)
                case .success(let product):
                    guard let productId = product.id else { return }
                    // if the cartProducts didnt contain (product.id == productId) then add this product
                    if !self.cartProducts.contains(where: { product in
                        return product.id == productId
                    }) {
                        self.cartProducts.append(product)
                    }
                }
            }
        }
    }
    
    //MARK: - Update Cart in Firestore
    
    func updateCart(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        if quantity > 0 {
            userRef.updateData(["cart.\(productId)" : quantity]) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful()
                }
            }
            
        } else {
            userRef.updateData(["cart.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.errorHapped(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful()
                }
            }
        }
    }
    //MARK: - FetchCost according to ProductCount
    
    func fetchCostAccToCount(cart: [String: Int]) {
        let productsRef = database.collection("products")
        for (id, quantity) in cart {
            let product = productsRef.document(id)
            // here we calcculate the cost of every item and added to (costAccToItemCount)
            product.getDocument { documentData, error in
                guard let documentData = documentData  else { return }
                if documentData.exists == true {
                    var cost: Double = 0
                    guard let price = documentData.get("price") as? Double else { return }
                    cost = price * Double(quantity)
                    self.costAccToItemCount[id, default: 0] = cost
                } else {
                    self.costAccToItemCount = [:]
                }
            }
            
        }
    }
    //MARK: - TotalCost
    // every cost on every item + to get the total cost
    var totalCost: Double {
        var total: Double = 0
        for (_, cost) in costAccToItemCount {
            total += cost
        }
        return total.rounded(toPlaces: 2)
    }
    
    //MARK: - Checkout
    
    func checkout() {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        if cartProducts.count == 0 {
            self.delegate?.didCheckoutNotSuccessful()
        } else {
            for product in cartProducts {
                if let productId = product.id {
                    userRef.updateData(["cart.\(productId)" : FieldValue.delete()]) { error in
                        if let error = error {
                            self.delegate?.errorHapped(error)
                        } else {
                            self.cartProducts = []
                            self.delegate?.didUpdateCartSuccessful()
                            self.delegate?.didCheckoutSuccessful()
                        }
                    }
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
            self.delegate?.errorHapped(error)
        }

    }

    //MARK: - GetProductIndexPath
    
    func getProductIndexPath(productId: Int) -> IndexPath {
        let index = cartProducts.firstIndex { product in
            product.id == productId
        }
        if let index = index {
            return IndexPath(row: index, section: 0)
        }
        return IndexPath()
    }
    
    
    //MARK: - RemoveProduct
    
    func removeProduct(index: Int, productId: String) {
        cartProducts.remove(at: index)
        costAccToItemCount.removeValue(forKey: productId)
    }
}
