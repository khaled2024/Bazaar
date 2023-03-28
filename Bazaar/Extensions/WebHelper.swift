//
//  WebHelper.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import Foundation
//MARK: - fetchAllProducts
enum AllProductsWebEndPoint {
    case fetchAllProducts
    var path: String {
        switch self {
        case .fetchAllProducts:
            return NetworkHelper.shared.requestURL(url: "/products?limit=0")
        }
    }
}
//MARK: - fetchAllCategories
enum AllCategoriesWebEndPoint {
    case fetchAllCategories
    var path: String {
        switch self {
        case .fetchAllCategories:
            return NetworkHelper.shared.requestURL(url:"/products/categories")
        }
    }
}

//MARK: - fetch product by category
enum ProductByCategoryWebEndPoint {
    case fetchProductByCategory(category: String)
    var path: String {
        switch self {
        case .fetchProductByCategory(let category):
            return NetworkHelper.shared.requestURL(url:"/products/category/\(category)")
        }
    }
}
//MARK: - fetch Single Product...
enum SingleProductWebEndPoint {
    case fetchSingleProduct(id: Int)
    var path: String {
        switch self {
        case .fetchSingleProduct(id: let id):
            return NetworkHelper.shared.requestURL(url: "/products/\(id)")
        }
    }
}

