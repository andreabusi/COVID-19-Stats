//
//  StatsTimeSeriesRow.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct StatsTimeSeriesRow: View {
   private let viewModel: StatsTimeSeriesRowViewModel
   
   // MARK: - Init
   
   init(viewModel: StatsTimeSeriesRowViewModel) {
      self.viewModel = viewModel
   }
   
   // MARK: - View
   
   var body: some View {
      HStack {
         VStack {
            Text("\(viewModel.value)").font(.headline)
            Text(viewModel.date).font(.caption)
         }
         Spacer()
         evolution
      }
   }
   
   private var evolution: some View {
      let percentage = viewModel.percentage
      if percentage.isEmpty {
         return Text("-")
      }
      
      let arrow = viewModel.hasDecreased ? "↓" : "↑"
      return Text("\(arrow) \(percentage)").foregroundColor(viewModel.hasDecreased ? .green : .red)
   }
}

struct StatsTimeSeriesRow_Previews: PreviewProvider {
   static var previews: some View {
      StatsTimeSeriesRow(viewModel: StatsTimeSeriesRowViewModel.preview_viewModel())
   }
}
