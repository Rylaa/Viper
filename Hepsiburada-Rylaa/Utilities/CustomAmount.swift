//
//  CustomAmount.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

struct CustomAmount {
    
    private var doubleAmount: Double = 0.0
    
    public var amountForRequest: String {
        return "\(doubleFormat)"
    }
    
    public var doubleFormat: Double {
        return doubleAmount
    }
    
    public var currencyFormat: String? {
        return doubleToCurrency(input: doubleAmount)
    }
    
    /// ₺1234,45
    init?(₺icon: String) {
        if let converted = currencyToDouble(input: ₺icon) {
            doubleAmount = converted
        }else {
            return nil
        }
    }
    
    init?(doubleString: String) {
        if let converted = Double(doubleString) {
            doubleAmount = converted
        }else {
            return nil
        }
    }
    
    init(double: Double) {
        doubleAmount = double
    }
    
    
    private func currencyToDouble(input: String, _ currency: String = "₺") -> Double? {
        let formatter = NumberFormatter()
        let locale = Locale(identifier: "tr_TR")
        formatter.locale = locale
        formatter.currencySymbol = currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        return formatter.number(from: input)?.doubleValue
    }
    
    private func doubleToCurrency(input: Double) -> String? {
        let formatter = NumberFormatter()
        let locale = Locale(identifier: "tr_TR")
        formatter.locale = locale
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: input))
    }
    // Obje fonksiyonları
    static func + (lhs: CustomAmount, rhs: CustomAmount) -> CustomAmount {
        let result = lhs.doubleFormat + rhs.doubleFormat
        return CustomAmount(double: result)
    }
    
    static func - (lhs: CustomAmount, rhs: CustomAmount) -> CustomAmount {
        let result = lhs.doubleFormat - rhs.doubleFormat
        return CustomAmount(double: result)
    }
    
    static func > (lhs: CustomAmount, rhs: CustomAmount) -> Bool {
        return lhs.doubleFormat > rhs.doubleFormat
    }
    
    static func < (lhs: CustomAmount, rhs: CustomAmount) -> Bool {
        return lhs.doubleFormat < rhs.doubleFormat
    }
}

extension CustomAmount: Encodable {}
