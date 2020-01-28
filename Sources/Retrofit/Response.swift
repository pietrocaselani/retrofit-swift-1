//
//  Response.swift
//  Retrofit
//
//  Created by Guilherme Souza on 28/01/20.
//

import Foundation

/// Represents a response sent by the server in the request.
public struct Response {
    
    /// The response body content.
    public var body: Data
    
    /// The HTTP status code.
    public var statusCode: Int
    
    /// Header fields sent by the server in the request.
    public var headerFields: [AnyHashable: Any]
    
    public init(body: Data, statusCode: Int, headerFields: [AnyHashable: Any]) {
        self.body = body
        self.statusCode = statusCode
        self.headerFields = headerFields
    }
    
}

extension Response {
    func decode<T: Decodable>(type: T.Type = T.self, decoder: JSONDecoder = .init()) throws -> T {
        return try decoder.decode(type, from: body)
    }
}
