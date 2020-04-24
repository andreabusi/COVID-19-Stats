//
//  StatsDailyReportRow.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct StatsDailyReportRow: View {
   private let viewModel: StatsDailyReportRowViewModel
   
   // MARK: - Init
   
   init(viewModel: StatsDailyReportRowViewModel) {
      self.viewModel = viewModel
   }
   
   // MARK: - View
   
   var body: some View {
      VStack(alignment: .leading) {
         Text(viewModel.title)
            .font(.headline)
         Text(viewModel.subtitle)
            .font(.subheadline)
      }
   }
}


struct StatsDailyReportRow_Previews: PreviewProvider {
   static var previews: some View {
      StatsDailyReportRow(viewModel: StatsDailyReportRowViewModel.preview_viewModel())
   }
}
