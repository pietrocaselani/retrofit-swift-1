//
//  Middleware.swift
//  Retrofit
//
//  Created by Guilherme Souza on 28/01/20.
//

import Combine
import Foundation

public protocol Middleware {
    func respond(to request: URLRequest, andCallNext next: Responder) -> AnyPublisher<Response, Error>
}

extension RequestMiddleware {
    
    func makeResponder(chainingTo responder: Responder) -> Responder {
        MiddlewareResponder(middleware: self, responder: responder)
    }
}

extension Array where Element == RequestMiddleware {
    func makeResponder(chainingTo responder: Responder) -> Responder {
        var responder = responder
        
        for middleware in reversed() {
            responder = middleware.makeResponder(chainingTo: responder)
        }
        
        return responder
    }
}

internal struct MiddlewareResponder: Responder {
    
    let middleware: RequestMiddleware
    let responder: Responder
    
    func respond(to request: URLRequest) -> AnyPublisher<Response, Error> {
        return middleware.respond(to: request, andCallNext: responder)
    }
}
