//
//  DailyReportParser.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 20/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation
import SwiftCSV


class DailyReportParser {

    private static let CsvHeaderProvinceState = "Country/Region"
    private static let CsvHeaderConfirmed = "Confirmed"
    private static let CsvHeaderDeaths = "Deaths"
    private static let CsvHeaderRecovered = "Recovered"

    // MARK: - Init
    
    init() { }
    
    // MARK: - Public
    
    public func parseCsvContent(_ content: String) -> [DailyReport] {
        guard let csv = try? CSV(string: content, delimiter: ",", loadColumns: true) else { return [] }

        let rows = csv.namedRows
        
        // step 1: parse raw rows into DailyReport rows
        let allReports = rows.compactMap { dailyReport(from: $0) }
        
        // step 2: group rows for country, we don't need data splitted by province/state
        var groupedReports = [DailyReport]()
        for aReport in allReports {
            // if a country has been already grouped, skip the current report
            if groupedReports.first(where: { $0.country == aReport.country }) != nil {
                continue
            }
            
            // country not yet grouped, search for other rows of the same country
            let sameCountryReports = allReports.filter { $0.country == aReport.country }
            
            // sum stats for confirmed, deaths and recovered
            let countryConfirmed = sameCountryReports.reduce(0) { (a, b) in a + b.confirmed }
            let countryDeaths = sameCountryReports.reduce(0) { (a, b) in a + b.deaths }
            let countryRecovered = sameCountryReports.reduce(0) { (a, b) in a + b.recovered }
            
            // create a new DailyReport object with the aggregate values
            let countryReport = DailyReport(country: aReport.country,
                                            confirmed: countryConfirmed,
                                            deaths: countryDeaths,
                                            recovered: countryRecovered)
            groupedReports.append(countryReport)
        }
        
        return groupedReports        
    }
    
    // MARK: - Private
    
    private func dailyReport(from namedRow: [String: String]) -> DailyReport? {
        // check for required fields and create a DailyReport istance
        guard   let countryName = namedRow[Self.CsvHeaderProvinceState],
                let confirmedString = namedRow[Self.CsvHeaderConfirmed], let confirmed = Int(confirmedString),
                let deathsString = namedRow[Self.CsvHeaderDeaths], let deaths = Int(deathsString),
                let recoveredString = namedRow[Self.CsvHeaderRecovered], let recovered = Int(recoveredString) else {
            return nil
        }
        
        let report = DailyReport(country: countryName,
                                 confirmed: confirmed,
                                 deaths: deaths,
                                 recovered: recovered)
        return report
    }
}
