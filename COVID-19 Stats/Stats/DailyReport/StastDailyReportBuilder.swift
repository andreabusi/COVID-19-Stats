//
//  StastDailyReportBuilder.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI


enum StatsDailyReportBuilder {
   static func makeStatsTimeSeriesView(with dailyReport: DailyReport, fetcher: StatsFetchable) -> some View {
      let viewModel = StatsTimeSeriesViewModel(dailyReport: dailyReport, statsFetcher: fetcher)
      return StatsTimeSeriesView(viewModel: viewModel)
   }
}

extension StatsDailyReportRowViewModel {
   func timeSeriesView(with fetcher: StatsFetchable) -> some View {
      StatsDailyReportBuilder.makeStatsTimeSeriesView(with: report, fetcher: fetcher)
   }
}
