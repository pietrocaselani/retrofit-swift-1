import Foundation

public struct Single<T> {}

public protocol Service {
    static var baseURL: URL { get }
    
    func perform<T: Decodable>(request: URLRequest) -> Single<T>
}

final class Client: Service {
    
    static var baseURL: URL {
        URL(string: "https://google.com/")!
    }
    
    let session: URLSession = .shared
    
    func perform<T: Decodable>(request: URLRequest) -> Single<T> {
        
        let task = session.dataTask(with: request) { data, response, error in
            
        }

        task.resume()
        
        return Single<T>()
    }
}

struct User: Codable {}

struct Query<T> {
    let value : T
}

struct Path<T> {
    let value: T
}

struct Body<T: Encodable> {
    let value: T
}

struct Header<T> {
    let value: T
}

struct UpdatedUser: Codable {}

public struct Empty: Decodable {}

protocol UsersService: Service {
    
    // sourcery: path = "api/v1/users"
    // sourcery: method = "GET"
    func getAllUsers() -> Single<[User]>
    
    // sourcery: path = "api/v1/users"
    // sourcery: method = "POST"
    func postUser(user: Body<User>) -> Single<Empty>
    
    // sourcery: path = "api/v1/users/<userID>"
    // sourcery: method = "PUT"
    func putUser(userID: Path<String>, updateUser: Body<UpdatedUser>) -> Single<User>
    
    // sourcery: path = "api/v1/users/<userID>/address/<addressID>"
    // sourcery: method = "PUT"
    func putAddress(userID: Path<String>, addressID: Path<String>) -> Single<User>
}

extension Encodable {
    func encoded() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
