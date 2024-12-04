//
//  APIRequest.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import Foundation

final class APIRequestBuilder {
    private let host = "rickandmortyapi.com"
    private var request: URLRequest?
    
    
    private func url(endPoint: APIEndPoint) throws(APIErrorResponse) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = endPoint.path()
        if let url = components.url {
            return url
        } else {
            throw APIErrorResponse.badUrl
        }
    }
    
    func builRequest(endPoint: APIEndPoint) throws(APIErrorResponse) -> URLRequest {
        do {
            let url = try self.url(endPoint: endPoint)
            request = URLRequest(url: url)
            request?.httpMethod = endPoint.httpMethod()
            if let finalRequest = self.request {
                return finalRequest
            }
        } catch {
            throw error
        }
        throw APIErrorResponse.requestWasNil
    }

}



