//
//  APIErrorResponse.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import Foundation


enum APIErrorResponse: Error, CustomStringConvertible {
    
    case requestWasNil
    case errorFromServer(reason: Error)
    case errorFromApi(statusCode: Int)
    case dataNoReveiced
    case errorParsingData
    case sessionTokenMissing
    case badUrl
    case characterNotFound(idCharacter: String)
    
    var description: String {
        switch self {
            
        case .requestWasNil:
            return "Error creating request"
        case .errorFromServer(reason: let reason):
            return "Received error from server \((reason as NSError).code)"
        case .errorFromApi(statusCode: let statusCode):
            return "Received error from api status code \(statusCode)"
        case .dataNoReveiced:
            return "Data no received from server"
        case .errorParsingData:
            return "There was un error parsing data"
        case .sessionTokenMissing:
            return "Seesion token is missing"
        case .badUrl:
            return "Bad url"
        case .characterNotFound(idCharacter: let idCharacter):
            return "Hero with id \(idCharacter) not found"
        }
    }
}
