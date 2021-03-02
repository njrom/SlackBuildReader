//
//  FileParser.swift
//  SlackReader
//
//  Created by Nick Romano on 3/2/21.
//

import Foundation

class FileParser {
    
    static var shared = FileParser()
    private init() { }
    
    func loadMessages() -> [Message] {
        
        var messages: [Message] = []
        let startDateString = "2020-09-25"
        let endDateString = "2021-02-18"
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = dateFormatter.date(from: startDateString), let endDate = dateFormatter.date(from: endDateString) else {
            print("Date format invalid")
            fatalError()
        }
        var numberOfDays = Calendar.current.numberOfDaysBetween(startDate, and: endDate)
        var count = 0
        for i in 0...numberOfDays {
            let date = Calendar.current.date(byAdding: .day, value: i, to: startDate)!
            let dateString = dateFormatter.string(from: date)
            print(dateString)
            if let data = readLocalFile(forName: dateString), let dayMessages = parse(jsonData: data) {
                messages.append(contentsOf: dayMessages)
                count += 1
            } else {
                print("Could not read day \(dateString)")
            }
        }

        return messages
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "app-builds/\(name)",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Cannot read file \(name)")
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) -> [Message]? {
        do {
            let messages = try JSONDecoder().decode([Message].self, from: jsonData)
            return messages
        } catch {
            print("Decode Error")
            return nil
        }
    }
}
