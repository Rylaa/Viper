//
//  ErrorResponseModel.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

struct ErrorResponseParentModel: Codable {
    let success: Bool
    let error: ErrorResponseModel
}

struct ErrorResponseModel: Codable {
    let errorCode: String?
    let message: String
}
