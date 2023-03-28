//
//  Product.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import Foundation
struct ProductsResponse:Codable {
    let products: [Product]?
    let total, skip, limit: Int
}
struct Product: Codable,SpecialProductCellProtocol,ProductCollectionCellProtocol,ProductDetailViewProtocol,CartCollectionCellProtocol{
    
    
    let id: Int?
    let title: String?
    let description: String?
    
    let price: Int?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
    
    //MARK: - SpecialProductCellProtocol
    var specialImage: String{
        if let image = images?.first ?? images?.last{
            return image
        }
        
        return ""
    }
    var specialTitle: String{
        if let title = title{
            return title
        }
        return ""
    }
    var specialDescription: String{
        if let description = description{
            return description
        }
        return ""
    }
    //MARK: - Products collection cell protocol
    var productTitle: String{
        if let title = title{
            return title
        }
        return ""
    }
    
    var productId: Int{
        if let id = id{
            return id
        }
        return 0
    }
    
    var productRatingCount: Double{
        if let rating = rating{
            return rating
        }
        return 0.0
    }
    
    var productPrice: String{
        if let price = price{
            return "$\(price)"
        }
        return ""
    }
    
    var productBrand: String{
        if let brand = brand{
            return brand
        }
        return brand ?? ""
    }
    
    var productImage: String{
        if let image = images?.first ?? images?.last{
            return image
        }
        return ""
    }
    
    var productSold: String{
        if let stock = stock{
            return "\(stock) Sold"
        }
        return ""
    }
    //MARK: - Details product
    var productDetailTitle: String{
        if let title = title{
            return title
        }
        return ""
    }
    
    var productDetailDescription: String{
        if let description = description{
            return description
        }
        return ""
    }
    
    var productDetailPrice: String{
        if let price = price{
            return "$\(price)"
        }
        return ""
    }
    
    var productDetailRatingCount: Double{
        if let rating = rating{
            return rating
        }
        return 0.0
    }
    
    var productDetailSold: String{
        if let stock = stock{
            return "\(stock) Sold"
        }
        return ""
    }
    
    var productDetailBrand: String{
        if let brand = brand{
            return brand
        }
        return ""
    }
    
    var productDetailCategory: String{
        if let category = category{
            return category
        }
        return ""
    }
    
    var productDetailImage: String{
        if let image = images?.first{
            return image
        }
        return ""
    }
    //MARK: - Cart collectionVell Protocol
    var cartImage: String{
        if let image = images?.first{
            return image
        }
        return ""
    }
    
    var cartName: String{
        if let title = title{
            return title
        }
        return ""
    }
    
    var cartCategory: String{
        if let category = category{
            return category
        }
        return ""
    }
    
    var cartBrand: String{
        if let brand = brand{
            return brand
        }
        return ""
    }
    
    var cartPrice: String{
        if let price = price{
            return "$\(price)"
        }
        return ""
    }
    
    var cartID: Int{
        if let id = id{
            return id
        }
        return 0
    }
}
