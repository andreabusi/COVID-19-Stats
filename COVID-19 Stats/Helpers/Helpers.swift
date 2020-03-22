//
//  Helpers.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 15/03/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


class Helpers {
    
    // MARK: - Class
    
    class func flag(for country: String) -> String {
        let flags = [
            "china": "🇨🇳",
            "italy": "🇮🇹",
            "germany": "🇩🇪",
            "france": "🇫🇷",
            "spain": "🇪🇸",
            "us": "🇺🇸",
            "united kingdom": "🇬🇧",
            "australia": "🇦🇺",
            "austria": "🇦🇹",
            "portugal": "🇵🇹",
            "japan": "🇯🇵",
            "denmark": "🇩🇰",
            "iran": "🇮🇷",
            "switzerland": "🇨🇭",
            "norway": "🇳🇴",
            "sweden": "🇸🇪",
            "netherlands": "🇳🇱",
            "belgium": "🇧🇪",
            "qatar": "🇶🇦",
            "singapore": "🇸🇬",
            "malaysia": "🇲🇾",
            "canada": "🇨🇦",
            "greece": "🇬🇷",
            "bahrain": "🇧🇭",
            "israel": "🇮🇱",
            "finland": "🇫🇮",
            "brazil": "🇧🇷",
            "korea south": "🇰🇷",
            "cruise ship": "🚢",
            "czechia": "🇨🇿",
            "slovenia": "🇸🇮",
            "bulgaria": "🇧🇬"
        ]
        return flags[country.lowercased()] ?? ""
    }
    
    
    /// Returns the default formatter to convert file date in Date objects
    /// Date stored inside the csv files are in the format like 13/3/20
    static var fileDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yy"
        return formatter
    }()
}
