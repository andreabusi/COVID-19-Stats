//
//  DailyReportStructure.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


struct DailyReportStructure {
    let headerProvinceState: String
    let headerConfirmed: String
    let headerDeaths: String
    let headerRecovered: String
    
    // MARK: - Factory
    
    static func structure(for headers: [String]) -> DailyReportStructure {
        if headers.contains("FIPS") {
            // new CSV format (starting from 03-23-2020)
            return DailyReportStructure(headerProvinceState: "Country_Region",
                                        headerConfirmed: "Confirmed",
                                        headerDeaths: "Deaths",
                                        headerRecovered: "Recovered")
        } else {
            // old CSV format
            return DailyReportStructure(headerProvinceState: "Country/Region",
                                        headerConfirmed: "Confirmed",
                                        headerDeaths: "Deaths",
                                        headerRecovered: "Recovered")
        }
    }
}
