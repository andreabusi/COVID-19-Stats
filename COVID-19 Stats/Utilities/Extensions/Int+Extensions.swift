//
//  Int+Extensions.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 28/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


extension Int {
   var formatted: String {
      if let formatted = Constants.displayNumberFormatter.string(from: self as NSNumber) {
         return formatted
      }
      return "\(self)"
   }
}
