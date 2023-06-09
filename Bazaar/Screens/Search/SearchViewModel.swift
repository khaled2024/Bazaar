

import Foundation


protocol SearchViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchSearchProductsSuccessful()
    func didFetchSingleProduct(_ product: Product)
    func didFetchProductsByCategorySuccessful()
}

final class SearchViewModel {

    //MARK: - SearchViewModelDelegate
    
    weak var delegate: SearchViewModelDelegate?
    
    //MARK: - Properties
    
    let manager = Service.shared
    
    
    //MARK: - Products
    
    var products: [Product] = []
    var singleProduct: Product?
    var allCategories = Categories()

    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts) { response in
            if let products = response?.products {
                self.products = products
                self.delegate?.didFetchSearchProductsSuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    func fetchSingleProduct(productId id: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProduct(id: id)) { product in
            if let product = product {
                self.singleProduct = product
                self.delegate?.didFetchSingleProduct(product)
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    
    func fetchProductByCagetory(_ category: String) {
        manager.fetchProductByCategory(type: .fetchProductByCategory(category: category)) { response in
            if let products = response?.products {
                self.products = products
                self.delegate?.didFetchProductsByCategorySuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
            
        }
        
    }
}
