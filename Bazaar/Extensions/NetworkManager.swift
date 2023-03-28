//
//  NetworkManager.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import Foundation
import Alamofire
final class NetworkManager{
    deinit {
        print("deinit NetworkManager")
    }
    static let shared = NetworkManager()
    //MARK: - Main Request Function...
    func request<T>(path: String,onSuccess: @escaping (T)->(),onError: @escaping (AFError)->())where T: Codable{
        AF.request(path,encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            guard let model = response.value else{
                print(response.error?.localizedDescription as Any)
                return
            }
            onSuccess(model)
        }
    }
}
