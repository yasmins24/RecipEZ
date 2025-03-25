//
//  Request.swift
//  MindSet
//
//  Created by yasmin on 3/22/25.
//

import Alamofire
import Foundation

class Request {
    init(headers: HTTPHeaders) {
        self.headers = headers
    }
    
    private let headers: HTTPHeaders
    
    private func request(_ endpoint: String, method: HTTPMethod, parameters: Parameters? = nil) async -> Result<Data?, AFError> {
        await withCheckedContinuation { continuation in
            AF.request(endpoint, method: method, parameters: parameters, headers: headers).response { response in
                continuation.resume(returning: response.result)            }
        }
    }
    
    private func retrieveData(for result: Result<Data?, AFError>) throws -> Data? {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    func get(endpoint: String) async throws -> Data? {
        let result = await request(endpoint, method: .get)
        return try retrieveData(for: result)
    }
    
    func post(endpoint: String,  parameters: Parameters) async throws -> Data? {
        let result = await request(endpoint, method: .post, parameters: parameters)
        return try retrieveData(for: result)
    }
    
    func put(endpoint: String, parameters: Parameters) async throws -> Data?{
        let result = await request(endpoint, method: .put, parameters: parameters)
        return try retrieveData(for: result)
    }
    
    func delete(endpoint: String) async throws -> Data? {
        let result = await request(endpoint, method: .delete)
        return try retrieveData(for: result)
    }
}

extension HTTPHeaders {
    static func defaultHeaders(for key: String) -> HTTPHeaders {
        let xApiKey = HTTPHeader(name: "x-api-key", value: key)
        let contentType = HTTPHeader.contentType("application/json")
        let userAgent = HTTPHeader.defaultUserAgent
        let acceptEncoding = HTTPHeader.defaultAcceptEncoding
        let acceptLanguage = HTTPHeader.defaultAcceptLanguage
        return HTTPHeaders.init([xApiKey, contentType, userAgent, acceptEncoding, acceptLanguage])
    }
}

extension Data? {
    func data() throws -> Data {
        guard let data = self else {
            throw NetworkingError.dataError
        }
        return data
    }
}

enum NetworkingError: String, Error {
  case dataError = "Could not retrieve valid data"
}
