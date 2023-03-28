//
//  SpecialProductViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import UIKit
protocol SpecialProductViewModelDelegate:AnyObject {
    func errorHapped(_ error: Error)
    func didFetchAllSpecialProductsSuccessfully()
    func didFetchSingleProductSuccessfully(product: Product)
}
final class SpecialProductViewModel{
    weak var delegate: SpecialProductViewModelDelegate?
    var allSpecialProducts: [Product] = []
    private let service = Service.shared
    var singleProduct: Product?

    // when tapped on see More Btn
    func fetchAllSpecialProducts(){
        service.fetchProducts(type: AllProductsWebEndPoint.fetchAllProducts) { [weak self] (productsResponse) in
            if let products = productsResponse?.products{
                self?.allSpecialProducts = products
                self?.delegate?.didFetchAllSpecialProductsSuccessfully()
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
    }
    // when tapped to any specialProduct on Collection
    func fetchSingleSpecialProduct(productID: Int){
        service.fetchSingleProduct(type: .fetchSingleProduct(id: productID)) {[weak self] product in
            if let product = product{
                self?.singleProduct = product
                self?.delegate?.didFetchSingleProductSuccessfully(product: product)
            }
        } onError: { error in
            self.delegate?.errorHapped(error)
        }
    }
}
