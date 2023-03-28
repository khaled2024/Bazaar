//
//  Service.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import Alamofire

protocol ServiceProtocol {
    func fetchProducts(type: AllProductsWebEndPoint ,onSuccess: @escaping (ProductsResponse?) -> (), onError: @escaping (AFError) -> ())
}
final class Service: ServiceProtocol{
    deinit {
        print("deinit Service")
    }
    static let shared = Service()
    //MARK: - fetchAllProducts:-
    func fetchProducts(type: AllProductsWebEndPoint, onSuccess: @escaping (ProductsResponse?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        switch type {
        case .fetchAllProducts:
            url = AllProductsWebEndPoint.fetchAllProducts.path
        }
        NetworkManager.shared.request(path: url) { (response:ProductsResponse) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    //MARK: - fetchAllCategories:-
    func fetchCategories(type: AllCategoriesWebEndPoint, onSuccess: @escaping (Categories?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        switch type {
        case .fetchAllCategories:
            url = AllCategoriesWebEndPoint.fetchAllCategories.path
        }
        NetworkManager.shared.request(path: url) { (response:Categories) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    //MARK: - fetchProductByCategory:-
    func fetchProductByCategory(type: ProductByCategoryWebEndPoint, onSuccess: @escaping (ProductsResponse?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        switch type {
        case .fetchProductByCategory(let category):
            url = ProductByCategoryWebEndPoint.fetchProductByCategory(category: category).path
        }
        NetworkManager.shared.request(path: url) { (response:ProductsResponse) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    //MARK: -  fetch single product...
    func fetchSingleProduct(type: SingleProductWebEndPoint, onSuccess: @escaping (Product?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        switch type {
        case .fetchSingleProduct(let id):
            url = SingleProductWebEndPoint.fetchSingleProduct(id: id).path
        }
        NetworkManager.shared.request(path: url) { (response:Product) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    func fetchCategory(onSuccess: @escaping (Categories?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        NetworkManager.shared.request(path: "https://dummyjson.com/products/categories") { (response: Categories) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
}
