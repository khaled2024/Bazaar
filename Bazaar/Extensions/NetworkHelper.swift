//
//  NetworkHelper.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import Foundation
//MARK: - Network end Point
enum NetworkEndPoint: String {
//    case BASE_URL = "https://api.escuelajs.co/api/v1"
    case BASE_URL = "https://dummyjson.com"
//    case BASE_URL = "https://fakestoreapi.com"
}
final class NetworkHelper{
    deinit {
        print("deinit Network Helper")
    }
    static let shared = NetworkHelper()
    func requestURL(url: String)-> String{
        if let url = "\(NetworkEndPoint.BASE_URL.rawValue)\(url)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            return url
        }
        return "https://dummyjson.com/products"
    }
}
