//
//  DailyReport.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 15/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


/// This struct contains a daily report of a given country
struct DailyReport: Identifiable {
    typealias ID = UUID
    
    let id = UUID()
    var country: String
    var flag: String
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    
    // MARK: - Init
    
    init(country: String, confirmed: Int, deaths: Int, recovered: Int) {
        self.country = country
        self.flag = Helpers.flag(for: country)
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
    }
}
