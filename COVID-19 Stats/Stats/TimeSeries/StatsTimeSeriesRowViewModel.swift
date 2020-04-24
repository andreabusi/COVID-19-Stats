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
   var evolution: Float = 0.0
   var hasDecreased = false
   
   // MARK: - Init
   
   init(timeSeriesDay: TimeSeriesDay) {
      self.timeSeriesDay = timeSeriesDay

   }
   
   // MARK: - Accessories
   
   var date: String {
      let formatter = DateFormatter()
      formatter.timeStyle = .none
      formatter.dateStyle = .short
      return formatter.string(from: timeSeriesDay.date)
   }
   
   var value: Int {
      timeSeriesDay.value
   }
}
