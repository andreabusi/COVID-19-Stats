//
//  TimeSeriesView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 21/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct TimeSeriesView: View {
    @EnvironmentObject var reportManager: DailyReportManager

    var timeSeries: [TimeSeries] {
        return reportManager.timeSeries.sorted(by: { $0.country < $1.country })
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List(timeSeries) { timeSeries in
                        NavigationLink(destination: TimeSeriesDayView(timeSeries: timeSeries)) {
                            HStack {
                                TimeSeriesRow(timeSeries: timeSeries)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Time series")
        }
    }
}

struct TimeSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSeriesView()
        .environmentObject(DailyReportManager())
    }
}
