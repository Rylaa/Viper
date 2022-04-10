//
//  UrlProtocol.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

class SimuleURLSession: URLProtocol {
    
    static var stubResponseData: Data?
    static var stubURLResponse: HTTPURLResponse?
    static var stubError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let stubError = SimuleURLSession.stubError {
            self.client?.urlProtocol(self, didFailWithError: stubError)
        }else {
            self.client?.urlProtocol(self, didLoad: SimuleURLSession.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}

