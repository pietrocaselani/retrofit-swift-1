// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Combine

extension DefaultClient: JokesService {
    
    
    func fetchRandomJoke() -> AnyPublisher<Joke, Error> {
        
        
            
        let path = "jokes/random"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                    
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "GET"
    
                
        return perform(request: request)
    }
    
    
    func fetchRandomJoke(from category: Query<String>) -> AnyPublisher<Joke, Error> {
        
        
            
        let path = "jokes/random"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                        
        component.queryItems = (component.queryItems ?? []) + [
                    URLQueryItem(name: "category", value: category.value.description),
                ]
        
            
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "GET"
    
                
        return perform(request: request)
    }
    
    
    func fetchAllJokes() -> AnyPublisher<[Joke], Error> {
        
        
            
        let path = "jokes/random"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                    
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "GET"
    
                
        return perform(request: request)
    }
    
    
    func fetchAllCategories() -> AnyPublisher<[String], Error> {
        
        
            
        let path = "jokes/categories"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                    
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "GET"
    
                
        return perform(request: request)
    }
    
    
    func fetchJokes(matching query: Query<String>) -> AnyPublisher<[Joke], Error> {
        
        
            
        let path = "jokes/search"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                        
        component.queryItems = (component.queryItems ?? []) + [
                    URLQueryItem(name: "query", value: query.value.description),
                ]
        
            
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "GET"
    
                
        return perform(request: request)
    }
    
    
    func createJoke(newJoke: Body<NewJoke>) -> AnyPublisher<Joke, Error> {
        
        
            
        let path = "jokes"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                    
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "POST"
    
                
        request.httpBody = newJoke.value.encoded()

                
        return perform(request: request)
    }
    
    
    func updateJoke( id: Path<String>, updatedJoke: Body<UpdateJoke>) -> AnyPublisher<Joke, Error> {
        
        
                    
            
        let path = "jokes/\(id.value.description)"
        
        let url = Self.baseURL.appendingPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
                    
        var request = URLRequest(url: component.url!)
    
                        
        request.httpMethod = "PUT"
    
                
        request.httpBody = updatedJoke.value.encoded()

                
        return perform(request: request)
    }
    
        
}
