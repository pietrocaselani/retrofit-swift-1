import Foundation
import Combine

public protocol Service {
    static var baseURL: URL { get }
}

public protocol Responder {
    func respond(to request: URLRequest) -> AnyPublisher<Response, Error>
}

public final class RootResponder: Responder {
    
    public let middlewares: [RequestMiddleware]
    
    public init(middlewares: [RequestMiddleware]) {
        self.middlewares = middlewares
    }
    
    public func respond(to request: URLRequest) -> AnyPublisher<Response, Error> {
        return middlewares
            .makeResponder(chainingTo: self)
            .respond(to: request)
    }
    
}

final class PerformHTTPRequestResponder: Responder {
    
    public let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    func respond(to request: URLRequest) -> AnyPublisher<Response, Error> {
        return session.dataTaskPublisher(for: request)
            .map { data, response in
                let httpResponse = response as! HTTPURLResponse
                return Response(
                    body: data,
                    statusCode: httpResponse.statusCode,
                    headerFields: httpResponse.allHeaderFields
                )
        }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
    
}

public struct Query<T: CustomStringConvertible> {
    public let value : T
    
    public init(_ value: T) {
        self.value = value
    }
}

public struct Path<T: CustomStringConvertible> {
    public let value : T
    
    public init(_ value: T) {
        self.value = value
    }
}

public struct Body<T: Encodable> {
    public let value : T
    
    public init(_ value: T) {
        self.value = value
    }
}

public struct Header<T: CustomStringConvertible> {
    public let value : T
    
    public init(_ value: T) {
        self.value = value
    }
}

public struct Empty: Decodable {
    public init() {}
}

extension Encodable {
    func encode(encoder: JSONEncoder = .init()) throws -> Data {
        return try encoder.encode(self)
    }
}

extension Data {
    func decode<T: Decodable>(type: T.Type = T.self, decoder: JSONDecoder = .init()) throws -> T {
        return try decoder.decode(type, from: self)
    }
}
