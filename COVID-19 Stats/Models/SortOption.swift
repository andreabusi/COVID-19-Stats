//
//  SortOption.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 19/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


enum SortOption: Int, CustomStringConvertible, CaseIterable {
    case alphabeticAscending
    case alphabeticDescending
    case mostConfirmed
    case lessConfirmed
    case mostDeaths
    case lessDeaths
    
    // MARK: - CustomStringConvertible

    var description: String {
        switch self {
        case .alphabeticAscending:  return "By country name, ascending"
        case .alphabeticDescending: return "By country name, descending"
        case .mostConfirmed:        return "By most confirmed cases"
        case .lessConfirmed:        return "By less confirmed cases"
        case .mostDeaths:           return "By most deaths"
        case .lessDeaths:           return "By less deaths"
        }
    }
    
    // MARK: - Public
    
    mutating func next() {
        let sort = SortOption(rawValue: self.rawValue + 1) ?? .alphabeticAscending
        self = sort
    }
}
