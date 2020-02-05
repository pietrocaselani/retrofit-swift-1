//
//  LoggerMiddleware.swift
//  Retrofit
//
//  Created by Guilherme Souza on 28/01/20.
//

import Foundation
import Combine

@available(OSX 10.15, *)
public final class LoggerMiddleware: RequestMiddleware {
    
    public init() {}
    
    public func respond(to request: URLRequest, andCallNext next: Responder) -> AnyPublisher<Response, Error> {
        
        Self.debugLog("[Will perform request]:")
        Self.debugLog("\(request.httpMethod!) \(request.url!.absoluteString)")
        Self.debugLog("Body: \(String(bytes: request.httpBody ?? Data(), encoding: .utf8) ?? "<empty>")")
        
        return next.respond(to: request)
            .handleEvents(
                receiveSubscription: { _ in Self.debugLog("[Started request]") },
                receiveOutput: { response in
                    Self.debugLog("[Request finished with response]")
                    Self.debugLog("Status code: \(response.statusCode)")
                    Self.debugLog("Header Fields: \(response.headerFields)")
                    Self.debugLog("Response: \(String(bytes: response.body, encoding: .utf8) ?? "<empty>")")
            },
                receiveCompletion: { completion in
                    Self.debugLog(completion)
                    switch completion {
                    case .failure(let error):
                        Self.debugLog("[Request finished with Error]")
                        Self.debugLog(error)
                    case .finished: ()
                    }
            },
                receiveCancel: { Self.debugLog("[Request canceled]") },
                receiveRequest: { demand in Self.debugLog(demand) }
        ).eraseToAnyPublisher()
        
    }
    
    private static func debugLog(_ value: Any) {
        #if DEBUG
        dump(value)
        #endif
    }
    
}
