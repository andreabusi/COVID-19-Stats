//
//  AppView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 21/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            DailyReportView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily report")
            }
            
            TimeSeriesView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Time series")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(DailyReportManager())
    }
}
