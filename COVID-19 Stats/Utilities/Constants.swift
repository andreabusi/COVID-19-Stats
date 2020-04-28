//
//  Constants.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 27/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


enum Constants {
   
   /// Returns the default formatter to convert file date in Date objects
   /// Date stored inside the csv files are in the format like 13/3/20
   static var fileDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "M/dd/yy"
      return formatter
   }()
   
   /// Returns the formatter to use when display a date
   static var displayDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      return formatter
   }()
   
   /// Returns the formatter to use when display decimal numbers
   static var displayNumberFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
   }()
   
   /// Date with first data available on the remote CSV
   static var dailyReportStartDate: Date = {
      var components = DateComponents()
      components.day = 22
      components.month = 1
      components.year = 2020
      components.hour = 0
      components.minute = 0
      return Calendar.current.date(from: components)!
   }()
}
