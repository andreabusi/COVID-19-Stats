//
//  DailyReportManager.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 15/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation
import Combine


class DailyReportManager: ObservableObject {
    
    @Published var reports = [DailyReport]()    
    @Published var timeSeries = [TimeSeries]()
    @Published var date: String {
        didSet {
            self.downloadDailyReport()
        }
    }
    
    private let service = DataService()
    
    // MARK: - Init
    
    init(date: Date = Date()) {
        self.date = date.bud_formatted()
        #if DEBUG
        self.reports = DailyReportManager.sampleReports
        //self.timeSeries = DailyReportManager.sampleTimeSeries
        #endif
        
        self.downloadDailyReport()
        self.downloadTimeSeries()
    }
    
    // MARK: - Private
    
    private func downloadDailyReport() {
        service.fetchDailyReport(for: self.date) { (result) in
            switch result {
            case .success(let reports):
                self.reports = reports
            case .failure(let error):
                print("[DailyReportManager] Download report failed: \(error.localizedDescription)")
                self.reports = []
            }
        }
    }
    
    private func downloadTimeSeries() {
        service.fetchTimeSeries(for: .confirmed) { (result) in
            switch result {
            case .success(let timeSeries):
                self.timeSeries = timeSeries
            case .failure(let error):
                print("[DailyReportManager] Download time series failed: \(error.localizedDescription)")
                self.timeSeries = []
            }
        }
    }
}

#if DEBUG
extension DailyReportManager {
    
    static var sampleReports: [DailyReport] {
        [
            DailyReport(country: "China", confirmed: 80945, deaths: 3180, recovered: 100),
            DailyReport(country: "Italy", confirmed: 17660, deaths: 1266, recovered: 100),
            DailyReport(country: "Brazil", confirmed: 151, deaths: 0, recovered: 100),
            DailyReport(country: "France", confirmed: 3667, deaths: 79, recovered: 100),
            DailyReport(country: "US", confirmed: 2179, deaths: 47, recovered: 100),
            DailyReport(country: "Denmark", confirmed: 804, deaths: 0, recovered: 100)
        ]
    }
    
    static var sampleReport: DailyReport {
        DailyReportManager.sampleReports.randomElement()!
    }
    
    static var sampleTimeSeries: [TimeSeries] {
        [
            TimeSeries(country: "Italy", days: [
                TimeSeriesDay(date: Date(), value: 41035),
                TimeSeriesDay(date: Date().bud_adding(days: -1), value: 47021),
            ]),
            TimeSeries(country: "Japan", days: [
                TimeSeriesDay(date: Date(), value: 924),
                TimeSeriesDay(date: Date().bud_adding(days: -1), value: 963),
            ])
        ]
    }
    
    static var sampleSingleTimeSeries: TimeSeries {
        DailyReportManager.sampleTimeSeries.randomElement()!
    }
}
#endif
