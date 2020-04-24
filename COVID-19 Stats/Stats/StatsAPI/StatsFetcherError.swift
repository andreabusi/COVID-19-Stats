//
//  StatsFetcherError.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


enum StatsFetcherError: Error, LocalizedError {
    case dailyReportNotFound
    
    var errorDescription: String? {
        switch self {
        case .dailyReportNotFound: return "Unable to get daily report for the given date"
        }
    }
}
