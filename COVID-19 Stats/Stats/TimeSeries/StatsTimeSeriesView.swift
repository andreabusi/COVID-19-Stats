//
//  StatsTimeSeriesView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct StatsTimeSeriesView: View {
   @ObservedObject var viewModel: StatsTimeSeriesViewModel
   
   // MARK: - Init
   
   init(viewModel: StatsTimeSeriesViewModel) {
      self.viewModel = viewModel
   }
   
   // MARK: - View
   
   var body: some View {
      List {
         headerSection
         timeSeriesTypeSection
         if viewModel.isLoadingData {
            loadingDataSection
         } else {
            timeSeriesSection
         }
      }
      .onAppear(perform: viewModel.refresh)
      .navigationBarTitle("\(viewModel.country)")
      .listStyle(GroupedListStyle())
   }
   
   private var headerSection: some View {
      Section {
         HStack {
            Text("Confirmed")
            Spacer()
            Text("\(viewModel.confirmed)")
         }
         HStack {
            Text("Deaths")
            Spacer()
            Text("\(viewModel.deaths)")
         }
         HStack {
            Text("Recovered")
            Spacer()
            Text("\(viewModel.recovered)")
         }
      }
   }
   
   private var timeSeriesTypeSection: some View {
      Section {
         Picker("Series", selection: $viewModel.seriesType) {
            ForEach(viewModel.allSeriesTypes, id:\.self) {
               Text("\($0.description)")
            }
         }.pickerStyle(SegmentedPickerStyle())
      }
   }
   
   private var timeSeriesSection: some View {
      Section {
         ForEach(viewModel.dataSource, content: StatsTimeSeriesRow.init(viewModel:))
      }
   }
   
   private var loadingDataSection: some View {
      Section {
         HStack {
            ActivityIndicator(isAnimating: $viewModel.isLoadingData, style: .medium)
            Text("Loading data...")
         }
      }
   }
}


struct StatsTimeSeriesView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         StatsTimeSeriesView(viewModel: StatsTimeSeriesViewModel.preview_viewModel())
      }
   }
}
