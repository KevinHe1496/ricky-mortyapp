//
//  APIEndPoint.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 18/11/24.
//

import Foundation

enum APIEndPoint{
    case characters
    
    func path() -> String {
        switch self {
            
        case .characters:
            return "/api/character"
        }
    }
    
    func httpMethod() -> String {
        switch self {
        default:
            return "GET"
        }
    }
}
