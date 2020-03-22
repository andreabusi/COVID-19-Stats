//
//  Date+Extensions.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 16/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


extension Date {
    
    // MARK: - Class
    
    static var bud_yesterday: Date {
        let today = Date()
        return today.bud_previousDate()
    }
    
    // MARK: - Public
    
    func bud_previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func bud_adding(days: Int) -> Date {
        let date = Calendar.current.date(byAdding: .day, value: days, to: self)
        return date ?? Date()
    }
    
    func bud_formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: self)
    }
}
