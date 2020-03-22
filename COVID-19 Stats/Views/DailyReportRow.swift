//
//  DailyReportRow.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 15/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct DailyReportRow: View {
    var report: DailyReport
    
    private var reportTitle: String {
        if report.flag.isEmpty {
            return report.country
        }
        return "\(report.flag) \(report.country)"
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(reportTitle)")
                .font(.headline)
            Text("\(report.confirmed) confirmed, \(report.deaths) deaths")
                .font(.subheadline)
        }
    }
}

struct DailyReportRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyReportRow(report: DailyReportManager.sampleReport)
    }
}
