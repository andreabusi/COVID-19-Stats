//
//  StatsDailyReportRowViewModel.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


class StatsDailyReportRowViewModel: Identifiable {
   
   let report: DailyReport
   private let flag: String?
   
   // MARK: - Init
   
   init(report: DailyReport) {
      self.report = report
      self.flag = Helpers.flag(for: report.country)
   }
   
   // MARK: - Accessories
   
   var id: String {
      report.country
   }
   
   var title: String {
      if let flag = flag {
          return "\(flag) \(report.country)"
      }
      return report.country
   }
   
   var subtitle: String {
      "\(report.confirmed) confirmed, \(report.deaths) deaths"
   }
}
