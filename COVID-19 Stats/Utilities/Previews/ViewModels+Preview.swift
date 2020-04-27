//
//  ViewModels+Preview.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


class StatsPreviewFetcher: StatsFetchable {
   func fetchDailyReport(for date: Date, completion: @escaping (Result<[DailyReport], Error>) -> Void) {
      completion(.success([]))
   }
   
   func fetchTimeSeries(for type: TimeSeriesType, completion: @escaping (Result<[TimeSeries], Error>) -> Void) {
      completion(.success([]))
   }
}

extension StatsDailyReportViewModel {
   static func preview_viewModel() -> StatsDailyReportViewModel {
      let fetcher = StatsPreviewFetcher()
      let viewModel = StatsDailyReportViewModel(statsFetcher: fetcher)
      viewModel.dataSource = DailyReport.preview_sampleReports().map(StatsDailyReportRowViewModel.init(report:))
      return viewModel
   }
}

extension StatsDailyReportRowViewModel {
   static func preview_viewModel() -> StatsDailyReportRowViewModel {
      let report = DailyReport.preview_sampleReport()
      let viewModel = StatsDailyReportRowViewModel(report: report)
      return viewModel
   }
}


extension StatsTimeSeriesViewModel {
   static func preview_viewModel() -> StatsTimeSeriesViewModel {
      let fetcher = StatsPreviewFetcher()
      let report = DailyReport.preview_sampleReport()
      let viewModel = StatsTimeSeriesViewModel(dailyReport: report, statsFetcher: fetcher)
      viewModel.dataSource = TimeSeries.preview_sampleTimeSeries().days.map(StatsTimeSeriesRowViewModel.init)
      return viewModel
   }
}

extension StatsTimeSeriesRowViewModel {
   static func preview_viewModel() -> StatsTimeSeriesRowViewModel {
      let day = TimeSeries.preview_sampleTimeSeriesDay()
      let viewModel = StatsTimeSeriesRowViewModel(timeSeriesDay: day)
      return viewModel
   }
}
