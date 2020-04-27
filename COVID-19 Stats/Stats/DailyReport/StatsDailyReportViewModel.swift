//
//  StatsDailyReportViewModel.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI
import Combine


enum StatsDailyReportSort: CaseIterable {
    case alphabeticAscending
    case alphabeticDescending
    case mostConfirmed
    case lessConfirmed
    case mostDeaths
    case lessDeaths
}

class StatsDailyReportViewModel: ObservableObject, Identifiable {
   @Published var date: Date
   @Published var sort = StatsDailyReportSort.mostConfirmed
   @Published var dataSource = [StatsDailyReportRowViewModel]()
   @Published var isLoadingData = false
   
   let allSorts: [StatsDailyReportSort]
   let allDates: [Date]
   
   let statsFetcher: StatsFetchable
   private var disposables = Set<AnyCancellable>()
   
   // MARK: - Init
   
   init(statsFetcher: StatsFetchable) {
      self.statsFetcher = statsFetcher
      self.allSorts = StatsDailyReportSort.allCases
      self.allDates = Date.bud_dates(from: Constants.dailyReportStartDate, to: Date()).reversed()
      self.date = allDates[1]
      
      $date
         .sink(receiveValue: fetchDailyReport(for:))
         .store(in: &disposables)
      
      $sort
         .sink(receiveValue: sortDataSource(by:))
         .store(in: &disposables)
   }
   
   // MARK: - Private
   
   private func fetchDailyReport(for date: Date) {
      isLoadingData = true
      statsFetcher.fetchDailyReport(for: date) { [weak self] result in
         defer { self?.isLoadingData = false }
         
         guard let self = self else { return }
         
         switch result {
         case .success(let reports):
            let rows = reports.map { StatsDailyReportRowViewModel(report: $0) }
            self.dataSource = self.sorted(rows: rows, by: self.sort)
         case .failure:
            self.dataSource = []
         }
      }
   }
   
   private func sortDataSource(by sort: StatsDailyReportSort) {
      dataSource = sorted(rows: dataSource, by: sort)
   }
   
   private func sorted(rows: [StatsDailyReportRowViewModel], by sort: StatsDailyReportSort) -> [StatsDailyReportRowViewModel] {
      // todo: possiamo usare keyPath?
      switch sort {
      case .alphabeticAscending:    return rows.sorted(by: { $0.report.country < $1.report.country })
      case .alphabeticDescending:   return rows.sorted(by: { $0.report.country > $1.report.country })
      case .mostConfirmed:          return rows.sorted(by: { $0.report.confirmed > $1.report.confirmed })
      case .lessConfirmed:          return rows.sorted(by: { $0.report.confirmed < $1.report.confirmed })
      case .mostDeaths:             return rows.sorted(by: { $0.report.deaths > $1.report.deaths })
      case .lessDeaths:             return rows.sorted(by: { $0.report.deaths < $1.report.deaths })
      }
   }
}


extension StatsDailyReportSort: CustomStringConvertible {
   
   // MARK: - CustomStringConvertible

   var description: String {
       switch self {
       case .alphabeticAscending:  return "By country name, ascending"
       case .alphabeticDescending: return "By country name, descending"
       case .mostConfirmed:        return "By most confirmed cases"
       case .lessConfirmed:        return "By less confirmed cases"
       case .mostDeaths:           return "By most deaths"
       case .lessDeaths:           return "By less deaths"
       }
   }

}
