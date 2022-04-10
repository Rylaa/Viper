//
//  Date+Extensions.swift
//  Yusuf Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

enum DateFormatterType: String {
    case dayMonthYear = "dd MMM YYYY" // 28 Dec 2022
    case isoDateFormatted = "yyyy-MM-dd'T'HH:mm:ssZ" // 2021-12-28T12:27:53+0000 "2017-02-10T08:00:00Z"
    // LINK: https://nsdateformatter.com
}


extension String {
    func fromIsoDateFormat(to format: DateFormatterType, outputFormat: DateFormatterType = .dayMonthYear ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR") // TODO: Multi language için düşünülmeli.
        dateFormatter.dateFormat = DateFormatterType.isoDateFormatted.rawValue
        if let date = dateFormatter.date(from: self) {
            let formattedDate = date.toString(outputFormat)
            return formattedDate
        } else {
            return ""
        }
    }
}

extension Date {
    func toString(_ format: DateFormatterType = .dayMonthYear) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR") // TODO: Multi language için düşünülmeli.
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

