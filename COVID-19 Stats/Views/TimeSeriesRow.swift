//
//  TimeSeriesRow.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 21/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct TimeSeriesRow: View {
    let timeSeries: TimeSeries
    
    private var reportTitle: String {
        if timeSeries.flag.isEmpty {
            return timeSeries.country
        }
        return "\(timeSeries.flag) \(timeSeries.country)"
    }
    
    var body: some View {
        HStack {
            Text("\(reportTitle)")
                .font(.headline)
        }
    }
}

struct TimeSeriesRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeSeriesRow(timeSeries: DailyReportManager.sampleSingleTimeSeries)
    }
}
