//
//  HttpLayer.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//
import Foundation

protocol NetworkProtocol: HTTPMethods {
    var session: URLSession { get set }
    var resultQueue: DispatchQueue { get set }
}
 
protocol HTTPMethods: AnyObject {
    func get<T>(url: String, completion: @escaping (Result<T>) -> Void) where T: Codable
    func post<T>(url: String, completion: @escaping (Result<T>) -> Void) where T: Codable
    func put<T>(url: String, completion: @escaping (Result<T>) -> Void) where T: Codable
}

final class NetworkLayer: NetworkProtocol {

    var session: URLSession
    var resultQueue: DispatchQueue
    
    public init(resultQueue: DispatchQueue = .main, _ session: URLSession = NetworkDefaults().configuration()) {
        self.resultQueue = resultQueue
        self.session = session
    }
    
    func get<T>(url: String, completion: @escaping (Result<T>) -> Void) where T: Codable {
        guard let url = URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") else {
            return completion(.failure(NetworkError.invalidUrl(url)))
        }
        
        let request = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            self.resultQueue.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let error = self.handleError(response: response, with: data) {
                    completion(.failure(error))
                }
                
                if let data = data, !data.isEmpty {
                    GenericParser<T>()
                        .parse(data: data, completion: completion)
                }
            }
        }
        request.resume()
    }
    
    func post<T>(url: String, completion: @escaping (Result<T>) -> Void) where T : Decodable, T : Encodable {}
    func put<T>(url: String, completion: @escaping (Result<T>) -> Void) where T : Decodable, T : Encodable {}
}

fileprivate extension NetworkLayer {
    func handleError(response: URLResponse?, with data: Data?) -> NetworkError? {
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            if response.statusCode == 401 {
               return NetworkError.serverError(code: 401, error: "Session Hata", stringCode: nil)
                
            }else if response.statusCode == 500 {
                return NetworkError.serverError(code: 500, error: "Teknik bir hata (500)", stringCode: nil)
            }else {
                if let data = data,
                    let mesaj = try? JSONDecoder().decode(ErrorResponseParentModel.self, from: data) {
                    return NetworkError.serverError(code: 0, error: mesaj.error.message, stringCode: mesaj.error.errorCode ?? "")
                }
            }
        }
        return nil
    }
}
