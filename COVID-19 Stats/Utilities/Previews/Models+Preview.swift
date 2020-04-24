//
//  Models+Preview.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


extension DailyReport {

   static func preview_sampleReports() -> [DailyReport] {
      [
         DailyReport(country: "China", confirmed: 80945, deaths: 3180, recovered: 100),
         DailyReport(country: "Italy", confirmed: 17660, deaths: 1266, recovered: 100),
         DailyReport(country: "Brazil", confirmed: 151, deaths: 0, recovered: 100),
         DailyReport(country: "France", confirmed: 3667, deaths: 79, recovered: 100),
         DailyReport(country: "US", confirmed: 2179, deaths: 47, recovered: 100),
         DailyReport(country: "Denmark", confirmed: 804, deaths: 0, recovered: 100)
      ]
   }
   
   static func preview_sampleReport() -> DailyReport {
      preview_sampleReports().randomElement()!
   }
}


extension TimeSeries {
   static func preview_sampleTimeSeries() -> TimeSeries {
      TimeSeries(country: "Italy", days: [
          TimeSeriesDay(date: Date(), value: 187000),
          TimeSeriesDay(date: Date().bud_adding(days: -1), value: 183000),
          TimeSeriesDay(date: Date().bud_adding(days: -2), value: 181000),
          TimeSeriesDay(date: Date().bud_adding(days: -3), value: 178000),
          TimeSeriesDay(date: Date().bud_adding(days: -4), value: 175000),
          TimeSeriesDay(date: Date().bud_adding(days: -5), value: 172000),
          TimeSeriesDay(date: Date().bud_adding(days: -6), value: 168000),
          TimeSeriesDay(date: Date().bud_adding(days: -7), value: 165000),
          TimeSeriesDay(date: Date().bud_adding(days: -8), value: 162000),
          TimeSeriesDay(date: Date().bud_adding(days: -9), value: 159000)
      ])
   }
   
   static func preview_sampleTimeSeriesDay() -> TimeSeriesDay {
      preview_sampleTimeSeries().days.randomElement()!
   }
}
