//
//  ApiConstants.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

struct ApiConstants {
    
    static var baseUrl: String = {
        let baseUrl = "https://itunes.apple.com/"
        return baseUrl
    }()
    
    static var search = baseUrl + "search?term=%@&limit=%@&entity=%@"
    
}
