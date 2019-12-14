import Foundation
import Combine

public protocol Service {
    static var baseURL: URL { get }
}

public enum HTTP {
    public typealias Query = [String: String]
}

public protocol Queryable {
    func encoded() throws -> HTTP.Query
}

public protocol Client {
    func perform<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
}

public final class DefaultClient: Client {
    
    public let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func perform<T>(request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder()) // FIXME: Inject decoder
            .eraseToAnyPublisher()
    }
    
}

public struct Query<T: CustomStringConvertible> {
    public let value : T
    
    public init(_ value: T) {
        self.value = value
    }
}

public struct Queries<T: Queryable> {
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
    func encoded() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
