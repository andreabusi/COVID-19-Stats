//
//  StatsDailyReportView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI


struct StatsDailyReportView: View {
   @ObservedObject var viewModel: StatsDailyReportViewModel
   
   // MARK: - Init
   
   init(viewModel: StatsDailyReportViewModel) {
      self.viewModel = viewModel
   }
   
   // MARK: - View
   
   var body: some View {
      NavigationView {
         Form {
            filtersSection
            
            if viewModel.dataSource.isEmpty {
               emptySection
            } else {
               dailyReportSection
            }
         }
         .navigationBarTitle("Daily Report")
      }
   }
   
   // MARK: - Private
   
   var filtersSection: some View {
      Section {
         Picker(selection: $viewModel.date, label: Text("Select a date")) {
            ForEach(viewModel.allDates, id: \.self) {
                Text("\($0)").tag($0)
            }
         }
         
         Picker(selection: $viewModel.sort, label: Text("Select a sorting")) {
            ForEach(viewModel.allSorts, id:\.self) {
               Text("\($0.description)")
            }
         }
      }
   }
   
   var dailyReportSection: some View {
      Section {
         List(viewModel.dataSource) { row in
            NavigationLink(destination: row.timeSeriesView(with: self.viewModel.statsFetcher)) {
               StatsDailyReportRow(viewModel: row)
            }
         }
      }
   }
   
   var emptySection: some View {
      Section {
         VStack {
            Image(systemName: "tray")
            Text("There are no data for the selected date")
         }
      }
   }
}


struct StatsDailyReportView_Previews: PreviewProvider {
   static var previews: some View {
      StatsDailyReportView(viewModel: StatsDailyReportViewModel.preview_viewModel())
   }
}
