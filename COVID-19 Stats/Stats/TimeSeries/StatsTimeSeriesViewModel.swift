//
//  StatsTimeSeriesViewModel.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI
import Combine


class StatsTimeSeriesViewModel: ObservableObject, Identifiable {
   @Published var dataSource = [StatsTimeSeriesRowViewModel]()
   @Published var seriesType = TimeSeriesType.confirmed
   @Published var isLoadingData = false
   
   let allSeriesTypes: [TimeSeriesType]
   
   private let dailyReport: DailyReport
   private let statsFetcher: StatsFetchable
   private var disposables = Set<AnyCancellable>()
   
   // MARK: - Init
   
   init(dailyReport: DailyReport, statsFetcher: StatsFetchable) {
      self.dailyReport = dailyReport
      self.statsFetcher = statsFetcher
      self.allSeriesTypes = TimeSeriesType.allCases
      
      $seriesType
         .dropFirst(1)
         .sink(receiveValue: refresh(for:))
         .store(in: &disposables)
   }
   
   // MARK: - Accessories
   
   var country: String {
      dailyReport.country
   }
   
   var confirmed: Int {
      dailyReport.confirmed
   }
   
   var deaths: Int {
      dailyReport.deaths
   }
   
   var recovered: Int {
      dailyReport.recovered
   }
   
   // MARK: - Public
   
   func refresh() {
      refresh(for: seriesType)
   }
   
   // MARK: - Private
   
   private func refresh(for type: TimeSeriesType) {
      isLoadingData = true
      statsFetcher.fetchTimeSeries(for: type) { [weak self] result in
         defer { self?.isLoadingData = false }
         
         guard let self = self else { return }
         
         switch result {
         case .success(let timeSeries):
            guard let countryTimeSeries = timeSeries.filter({ $0.country.lowercased() == self.dailyReport.country.lowercased() }).first else {
               self.dataSource = []
               return
            }
            
            self.dataSource = self.createRows(for: countryTimeSeries.days)
         case .failure:
            self.dataSource = []
         }
      }
   }
   
   private func createRows(for days: [TimeSeriesDay]) -> [StatsTimeSeriesRowViewModel] {
      let sortedDays = days.sorted { $0.date.compare($1.date) == .orderedDescending }
      // calculate evolution for each day
      let viewModels = sortedDays
         .enumerated()
         .map { (index, element) -> StatsTimeSeriesRowViewModel  in
            let viewModel = StatsTimeSeriesRowViewModel(timeSeriesDay: element)
            if index < days.count - 1 {
               let currentDayValue = element.value
               let previousDayValue = sortedDays[index + 1].value
               let evolution = (Float(currentDayValue - previousDayValue) / Float(previousDayValue))
               
               viewModel.evolution = evolution
            }
            return viewModel
         }
      
      // check if the evolution has decreased against previous day
      viewModels.enumerated().forEach { (index, element) in
         if index < days.count - 1 {
            let currentDayEvolution = element.evolution
            let previousDayEvolution = viewModels[index + 1].evolution
            viewModels[index].hasDecreased = currentDayEvolution <= previousDayEvolution
         }
      }
      
      return viewModels
   }
}
