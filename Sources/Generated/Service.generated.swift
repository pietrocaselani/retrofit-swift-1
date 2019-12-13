// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation


extension Client: UsersService {
    
    
    func getAllUsers() -> Single<[User]> {
        let method = "GET"
        
        
            
        let path = "api/v1/users"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
    
        request.httpMethod = method
    
            return perform(request: request)
    }
    
    
    func postUser(user: Body<User>) -> Single<Empty> {
        let method = "POST"
        
        
            
        let path = "api/v1/users"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
    
        request.httpMethod = method
    
            request.httpBody = user.value.encoded()
            return perform(request: request)
    }
    
    
    func putUser(userID: Path<String>, updateUser: Body<UpdatedUser>) -> Single<User> {
        let method = "PUT"
        
        
            
            
        let path = "api/v1/users/\(userID.value)"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
    
        request.httpMethod = method
    
            request.httpBody = updateUser.value.encoded()
            return perform(request: request)
    }
    
    
    func putAddress(userID: Path<String>, addressID: Path<String>) -> Single<User> {
        let method = "PUT"
        
        
            
            
            
        let path = "api/v1/users/\(userID.value)/address/\(addressID.value)"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
    
        request.httpMethod = method
    
            return perform(request: request)
    }
    
        
}

