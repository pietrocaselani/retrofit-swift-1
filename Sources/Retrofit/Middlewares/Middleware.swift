//
//  Middleware.swift
//  Retrofit
//
//  Created by Guilherme Souza on 28/01/20.
//

import Combine
import Foundation

@available(OSX 10.15, *)
public protocol RequestMiddleware {
    func respond(to request: URLRequest, andCallNext next: Responder) -> AnyPublisher<Response, Error>
}

@available(OSX 10.15, *)
extension RequestMiddleware {

    func makeResponder(chainingTo responder: Responder) -> Responder {
        MiddlewareResponder(middleware: self, responder: responder)
    }
}

@available(OSX 10.15, *)
extension Array where Element == RequestMiddleware {
    func makeResponder(chainingTo responder: Responder) -> Responder {
        var responder = responder
        
        for middleware in reversed() {
            responder = middleware.makeResponder(chainingTo: responder)
        }
        
        return responder
    }
}

@available(OSX 10.15, *)
internal struct MiddlewareResponder: Responder {
    
    let middleware: RequestMiddleware
    let responder: Responder
    
    func respond(to request: URLRequest) -> AnyPublisher<Response, Error> {
        return middleware.respond(to: request, andCallNext: responder)
    }
}
