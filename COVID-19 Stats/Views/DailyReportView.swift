//
//  DailyReportView.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 14/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI

struct DailyReportView: View {
    @EnvironmentObject var reportManager: DailyReportManager
    
    private var sortedReports: [DailyReport] {
        switch sorting {
        case .alphabeticAscending:
            return reportManager.reports.sorted(by: { $0.country < $1.country })
        case .alphabeticDescending:
            return reportManager.reports.sorted(by: { $0.country > $1.country })
        case .mostConfirmed:
            return reportManager.reports.sorted(by: { $0.confirmed > $1.confirmed })
        case .lessConfirmed:
            return reportManager.reports.sorted(by: { $0.confirmed < $1.confirmed })
        case .mostDeaths:
            return reportManager.reports.sorted(by: { $0.deaths > $1.deaths })
        case .lessDeaths:
            return reportManager.reports.sorted(by: { $0.deaths < $1.deaths })
        }
    }
    
    private let dates: [String]
    @State private var sorting = SortOption.mostConfirmed
    
    // MARK: - Init
    
    init() {
        self.dates = (0..<10).map { Date().bud_adding(days: -$0).bud_formatted() }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $reportManager.date, label: Text("Select a date")) {
                        ForEach(dates, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    }
                    
                    Picker("Select a sorting", selection: $sorting) {
                        ForEach(SortOption.allCases, id: \.self) { sort in
                            Text("\(sort.description)")
                        }
                    }
                }
                
                Section {
                    if sortedReports.count > 0 {
                        List(sortedReports) { report in
                            NavigationLink(destination: DailyReportDetailView(report: report)) {
                                DailyReportRow(report: report)
                            }
                        }
                    } else {
                        Text("There are no data for the selected date")
                    }
                }
            }
            .navigationBarTitle("Daily report")
        }
    }
    
    // MARK: - Private
    
    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: date)
    }
}

struct DailyReportView_Previews: PreviewProvider {
    
    static var previews: some View {
        DailyReportView()
            .environmentObject(DailyReportManager())
    }
}
