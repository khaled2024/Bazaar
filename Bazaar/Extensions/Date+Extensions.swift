//
//  Date+Extensions.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 21/03/2023.
//

import Foundation
extension NSDate{
    func getCurrentHour()-> Int{
        let currentTime = Date()
        let calender = NSCalendar.current
        let component = calender.component(.hour, from: currentTime)
        return component
    }
}
