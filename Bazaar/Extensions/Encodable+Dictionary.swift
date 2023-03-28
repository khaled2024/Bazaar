//
//  Encodable+Dictionary.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 18/03/2023.
//

import Foundation
struct Json{
    static let encoder = JSONEncoder()
}
extension Encodable{
    // encode if i want to upload data to internet like now i want to upload user data to firebase
    var dictionary: [String:Any]{
        let data = (try? Json.encoder.encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
    }
}
