//
//  Date+Extensions.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

extension Date {
    static func dateFromRss(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"

        let date = dateFormatter.date(from: string)
        return date
    }
    
    func localizedString() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd MMM YYYY"
        dateFormatter.locale = Locale(identifier: "RU_ru")
        
        return dateFormatter.string(from: self)
    }
}
