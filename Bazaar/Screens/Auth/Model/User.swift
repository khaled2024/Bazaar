//
//  User.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.
//

import Foundation
struct User: Codable{
    let id: String?
    let username: String?
    let email: String?
    let cart: [Int:Int]?
    let wishList: [Int:Int]?
}
