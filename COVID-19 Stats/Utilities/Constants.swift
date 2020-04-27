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
}
