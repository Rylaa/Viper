//
//  ResourceLoader.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

class ResourceLoader {
    
    static func loadFile() throws -> Data {
        let bundle = Bundle.test
        let url = try bundle.url(forResource: "SearchResponse", withExtension: "json").unwrap()
        let data = try Data(contentsOf: url)
        return data
    }
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
