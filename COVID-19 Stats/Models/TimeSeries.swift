//
//  TimeSeries.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 21/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation

/// This struct contains a time series of a given country
struct TimeSeries: Identifiable {
    typealias ID = UUID
    
    let id = UUID()
    let type: TimeSeriesType
    let country: String
    var days: [TimeSeriesDay]
    
    // MARK: - Init
    
    init(type: TimeSeriesType = .confirmed, country: String, days: [TimeSeriesDay]) {
        self.type = type
        self.country = country
        self.days = days
    }
}

/// Type of a time series
enum TimeSeriesType: CaseIterable, CustomStringConvertible {
   case confirmed
   case deaths
   case recovered
   
   var filename: String {
      switch self {
      case .confirmed:   return "confirmed_global.csv"
      case .deaths:      return "deaths_global.csv"
      case .recovered:   return "Recovered.csv"
      }
   }
   
   var description: String {
      switch self {
      case .confirmed:  return "Confirmed"
      case .deaths:     return "Deaths"
      case .recovered:  return "Recovered"
      }
   }
}

/// Daily value of a time series
struct TimeSeriesDay: Identifiable {
    typealias ID = Date
    
    let date: Date
    let value: Int
    
    var id: TimeSeriesDay.ID {
        return date
    }
}



