//
//  Optional+Extensions.swift
//  Yusuf_Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation
extension Optional {
    struct FoundNilWhileUnwrappingError: Error { }
    func unwrap() throws -> Wrapped {
        switch self {
        case .some(let wrapped):
            return wrapped
        case .none:
            throw FoundNilWhileUnwrappingError()
        }
    }
}
