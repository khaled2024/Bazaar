//
//  Double+Extension.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 26/03/2023.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
