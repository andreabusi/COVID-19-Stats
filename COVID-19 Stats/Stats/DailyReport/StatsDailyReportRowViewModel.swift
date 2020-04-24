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
   
   // MARK: - Init
   
   init(report: DailyReport) {
      self.report = report
   }
   
   // MARK: - Accessories
   
   var id: String {
      report.country
   }
   
   var title: String {
      if report.flag.isEmpty {
          return report.country
      }
      return "\(report.flag) \(report.country)"
   }
   
   var subtitle: String {
      "\(report.confirmed) confirmed, \(report.deaths) deaths"
   }
}
