//
//  IntegrationTest.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import XCTest
@testable import Hepsiburada_Rylaa
import Foundation


class IntegrationTests: XCTestCase {
    
   
    private var networkProtocol: NetworkProtocol!
    
    override func setUp() {
        let configUrlSession = URLSessionConfiguration.ephemeral
        configUrlSession.protocolClasses = [SimuleURLSession.self]
        let session = URLSession(configuration: configUrlSession)
        networkProtocol = NetworkLayer(resultQueue: .main, session)
    }
    
    func test_HappyPath_Response() throws {
        let expect = expectation(description: "result happy path")
        let api = Api()
        api.network = networkProtocol as! NetworkLayer
        let mockJSON = try ResourceLoader.loadFile()
        SimuleURLSession.stubResponseData = mockJSON
        api.search(searchedText: "batman", page: 1, type: SegmentedStringType.movie.rawValue) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual((response.resultCount ?? 0) > 0, false)
                expect.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        expect.fulfill()
        wait(for: [expect], timeout: 15)
    }
    
    func test_Error_Response() throws {
        let expect = expectation(description: "result error")
        let api = Api()
        api.network = networkProtocol as! NetworkLayer
        SimuleURLSession.stubError = NetworkError.serverError(code: 500, error: "", stringCode: "")
        api.search(searchedText: "batman", page: 1, type: SegmentedStringType.movie.rawValue) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription.isEmpty, false)
                expect.fulfill()
            case .success(_):
                XCTFail()
            }
        }
        wait(for: [expect], timeout: 10)
    }
}
