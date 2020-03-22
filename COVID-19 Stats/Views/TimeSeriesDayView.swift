//
//  TimeSeriesDayView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 21/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct TimeSeriesDayView: View {
    private var timeSeries: TimeSeries
    private var days: [TimeSeriesDay]
    
    // MARK: - Init
    
    init(timeSeries: TimeSeries) {
        self.timeSeries = timeSeries
        self.days = []
        
        self.days = evaluateEvolution()
    }
    
    // MARK: - View
    
    var body: some View {
        List(days) { timeSeriesDay in
            Text("\(self.formatted(date: timeSeriesDay.date))")
            Spacer()
            Text("\(timeSeriesDay.value)")
            Spacer()
            Text("\(self.formatted(increment: timeSeriesDay.evolution))").foregroundColor(.red)
        }
        .navigationBarTitle(Text(timeSeries.country), displayMode: .inline)
    }
    
    // MARK: - Private
    
    private func evaluateEvolution() -> [TimeSeriesDay] {
        var days = timeSeries.days.sorted { $0.date.compare($1.date) == .orderedDescending }
        days.enumerated().forEach { (index, element) in
            if index < days.count - 1 {
                let currentDayValue = element.value
                let previousDayValue = days[index + 1].value
                let evolution = (Float(currentDayValue - previousDayValue) / Float(previousDayValue))
                
                days[index].evolution = evolution
            }
        }
        return days
    }
    
    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    private func formatted(increment: Float) -> String {
        if increment == Float.nan || increment == Float.infinity {
            return "-"
        }
        
        let percentage = increment * 100
        return String(format: "↑ %.2f %%", percentage)
    }
}

struct TimeSeriesDayView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSeriesDayView(timeSeries: DailyReportManager.sampleSingleTimeSeries)
    }
}
