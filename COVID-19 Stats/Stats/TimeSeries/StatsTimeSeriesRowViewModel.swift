//
//  StatsTimeSeriesRowViewModel.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


class StatsTimeSeriesRowViewModel: Identifiable {
   let timeSeriesDay: TimeSeriesDay
   var evolution: Float?
   var hasDecreased = false
   
   // MARK: - Init
   
   init(timeSeriesDay: TimeSeriesDay) {
      self.timeSeriesDay = timeSeriesDay
   }
   
   // MARK: - Accessories
   
   var date: String {
      return Constants.displayDateFormatter.string(from: timeSeriesDay.date)
   }
   
   var value: Int {
      timeSeriesDay.value
   }
   
   var percentage: String {
      guard let evolution = evolution else {
         return ""
      }
      
      guard let percentageFormatted = Constants.displayPercentageFormatter.string(from: evolution as NSNumber) else {
         return ""
      }
      
      return percentageFormatted
   }
}
