//
//  Double+Extensions.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

extension Double {
    func timeIntervalToDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
}
