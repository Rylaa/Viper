//
//  HomeWorker.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

extension Api: HomeWorkerConformable {
    func search(searchedText: String, page: Int, type: String, completion: @escaping (Result<SearchResponseModel>) -> Void) {
        let page = page * 20
        let url = String(format: ApiConstants.search, searchedText, String(page), type)
        network.get(url: url, completion: completion)
    }
}
