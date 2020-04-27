//
//  StatsFetcher.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 24/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import Foundation


protocol StatsFetchable {
   func fetchDailyReport(for date: Date, completion: @escaping (_ result: Result<[DailyReport], Error>) -> Void)
   func fetchTimeSeries(for type: TimeSeriesType, completion: @escaping (_ result: Result<[TimeSeries], Error>) -> Void)
}


class StatsFetcher: StatsFetchable {    
    typealias DailyReportCompletion = (_ result: Result<[DailyReport], Error>) -> Void
    typealias TimeSeriesCompletion = (_ result: Result<[TimeSeries], Error>) -> Void
    
    private let dailyReportsFolder: URL
    private let DailyReportUrl = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
    private let TimeSeriesUrl = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_"


    // MARK: - Init
    
    init() {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        // folder when daily reports file are cached inside the app
        let dailyReportsFolder = cacheDirectory.appendingPathComponent("daily_reports")
        if !FileManager.default.fileExists(atPath: dailyReportsFolder.path) {
           try! FileManager.default.createDirectory(at: dailyReportsFolder, withIntermediateDirectories: false, attributes: nil)
        }
        self.dailyReportsFolder = dailyReportsFolder
    }
    
    // MARK: - Public
    
    public func fetchDailyReport(for date: Date, completion: @escaping DailyReportCompletion) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let stringDate = formatter.string(from: date)
      
        // check for local cached data
        if let reports = localDailyReport(for: stringDate) {
            completion(.success(reports))
            return
        }
        
        // download daily report from GitHub
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            
            let name = self.filename(for: stringDate)
            let fileURL = URL(string: "\(self.DailyReportUrl)\(name)")!
            if let dataContent = try? Data(contentsOf: fileURL), let content = String(data: dataContent, encoding: .utf8) {
                let parser = DailyReportParser()
                let reports = parser.parseCsvContent(content)
                self.saveDownloadedDailyReport(with: content, for: stringDate)
                DispatchQueue.main.async {
                    completion(.success(reports))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(StatsFetcherError.dailyReportNotFound))
                }
            }
        }
    }
    
    public func fetchTimeSeries(for type: TimeSeriesType, completion: @escaping TimeSeriesCompletion) {
        // file is update every day with the same name, so we can't store it locally
        
        // download daily report from GitHub
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            
            let name = type.filename
            let fileURL = URL(string: "\(self.TimeSeriesUrl)\(name)")!
            if let dataContent = try? Data(contentsOf: fileURL), let content = String(data: dataContent, encoding: .utf8) {
                let parser = TimeSeriesParser()
                let timeSeries = parser.parseCsvContent(content)
                DispatchQueue.main.async {
                    completion(.success(timeSeries))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(StatsFetcherError.dailyReportNotFound))
                }
            }
        }
    }
    
    // MARK: - Local cache
    
    private func localDailyReport(for date: String) -> [DailyReport]? {
        let localFileURL = dailyReportsFolder.appendingPathComponent(filename(for: date))
        if FileManager.default.fileExists(atPath: localFileURL.path) {
            print("[DataService] local file found for date: \(date)")
            if let content = try? String(contentsOf: localFileURL) {
                let parser = DailyReportParser()
                let reports = parser.parseCsvContent(content)
                return reports
            }
        }
        print("[DataService] local file not available for date: \(date)")
        return nil
    }
    
    private func saveDownloadedDailyReport(with content: String, for date: String) {
        let localFileURL = dailyReportsFolder.appendingPathComponent(filename(for: date))
        if !FileManager.default.fileExists(atPath: localFileURL.path) {
            try? content.write(to: localFileURL, atomically: true, encoding: .utf8)
            print("[DataService] file saved locally for date: \(date)")
        }
    }
    
    // MARK: - Helpers
    
    private func filename(for date: String) -> String {
        return "\(date).csv"
    }
}
