//
//  TimeSeriesParser.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 21/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation
import SwiftCSV


class TimeSeriesParser {
    
    private static let CsvHeaderProvinceState = "Province/State"
    private static let CsvHeaderCountryRegion = "Country/Region"
    private static let CsvHeaderLatitude = "Lat"
    private static let CsvHeaderLongitude = "Long"
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - Public
    
    public func parseCsvContent(_ content: String) -> [TimeSeries] {
        guard let csv = try? CSV(string: content, delimiter: ",", loadColumns: true) else { return [] }
        
        // remove non used headers and store rows
        let nonDateHeaders = [Self.CsvHeaderProvinceState, Self.CsvHeaderCountryRegion, Self.CsvHeaderLatitude, Self.CsvHeaderLongitude].compactMap { $0.lowercased() }
        let dayHeaders = csv.header.filter { nonDateHeaders.contains($0.lowercased()) == false }
        let rows = csv.namedRows
        
        // retrieve all countries available inside the fils (some are duplicated)
        let allCountriesOpt = csv.namedColumns.filter { $0.key == Self.CsvHeaderCountryRegion }[Self.CsvHeaderCountryRegion]
        guard let allCountries = allCountriesOpt else { return [] }
        
        
        var groupedTimeSeries = [TimeSeries]()
        for country in allCountries {
            // if a country has been already grouped, skip the current report
            if groupedTimeSeries.first(where: { $0.country == country }) != nil {
                continue
            }

            // country not yet grouped, search for other rows of the same country
            let countryRows = rows.filter { $0[Self.CsvHeaderCountryRegion] == country }
            
            // sum the values for the same day
            var countryTotals = [String: Int]()
            dayHeaders.forEach { (header) in
                let dayTotal = countryRows.compactMap { $0[header] }.reduce(0) { $0 + (Int($1) ?? 0) }
                countryTotals[header] = dayTotal
            }
            
            // create a TimeSeries object with the total value and the date
            let days = countryTotals.compactMap { (day, value) -> TimeSeriesDay? in
                guard let date = Helpers.fileDateFormatter.date(from: day) else {
                    return nil
                }
                return TimeSeriesDay(date: date, value: value)
            }
            let timeSeries = TimeSeries(country: country, days: days)
            groupedTimeSeries.append(timeSeries)
        }
        
        return groupedTimeSeries
    }
}
