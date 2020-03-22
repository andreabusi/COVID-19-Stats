//
//  DailyReportDetailView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 15/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct DailyReportDetailView: View {
    var report: DailyReport
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(report.flag) \(report.country)")
                    .font(.title)
                    .bold()
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("Confirmed: \(report.confirmed)")
                Text("Deaths: \(report.deaths)")
                Text("Recovered: \(report.deaths)")
            }
            Spacer()
        }.padding()
    }
}

struct DailyReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DailyReportDetailView(report: DailyReportManager.sampleReport)
    }
}
