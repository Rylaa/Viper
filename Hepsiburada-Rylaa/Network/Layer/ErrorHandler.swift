//
//  ErrorHandler.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

protocol ErrorModifier: Error, LocalizedError, CustomNSError, Equatable {}

enum ErrorType: Int {
    case invalidJson
    case invalidUrl
    case invalidBody
}

enum NetworkError: ErrorModifier {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.errorCode == rhs.errorCode
    }
    case serverError(code:Int, error: String, stringCode: String?)
    case invalidJson(_ message: Error)
    case invalidUrl(_ url: String)
    case invalidBody(_ url: String, error: Error)
    
    var errorCode: Int {
        switch self {
        case .serverError(let code, _, _):
            return code
        case .invalidJson(_):
            return ErrorType.invalidBody.rawValue
        case .invalidUrl(_):
            return ErrorType.invalidUrl.rawValue
        case .invalidBody(_, error: _):
            return ErrorType.invalidBody.rawValue
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .serverError(_, let error, _):
            return error
        case .invalidJson:
            return "Invalid JsonParser"
        case .invalidUrl:
            return "Invalid URL"
        case .invalidBody(_, let error):
            return "Invalid Body \(error)"
        }
    }
    
  
}

