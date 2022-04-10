//
//  SearchResponseModel.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

struct SearchResponseModel: Codable {
    let resultCount: Int?
    let results: [SearchedItemDetailModel]?
}

struct SearchedItemDetailModel: Codable {
    let wrapperType: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionName: String?
    let releaseDate: String?
    let kind: String?
    let shortDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artworkUrl100
        case collectionPrice
        case collectionName
        case releaseDate
        case kind
        case shortDescription
    }
}

extension SearchedItemDetailModel: SearchedItemDetailProtocol {
    var uiShortDescription: String {
        return shortDescription ?? ""
    }
    
    var date: String {
        return releaseDate?.fromIsoDateFormat(to: .isoDateFormatted, outputFormat: .dayMonthYear) ?? "X"
    }
    
    var uiWrapperType: WrapperType? {
        return WrapperType(rawValue: wrapperType ?? "")
    }
    
    var uiArtworkUrl100: String {
        return artworkUrl100 ?? ""
    }
    
    var uiCollectionPrice: CustomAmount {
        return CustomAmount(double: collectionPrice ?? 0)
    }
    
    var uiCollectionName: String {
        return collectionName ?? ""
    }
    
    var uiKind: Kind? {
        return Kind(rawValue: kind ?? "")
    }
}


