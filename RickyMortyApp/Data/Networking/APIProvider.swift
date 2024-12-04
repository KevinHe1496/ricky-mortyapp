//
//  APIProvider.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 2/12/24.
//

import Foundation

protocol APIProviderProtocol {
    func loadCharacters() async throws -> Characters
}

final class APIProvider: APIProviderProtocol {
    
    private let session: URLSession
    private let requestBuilder: APIRequestBuilder
    
    init(session: URLSession = .shared, requestBuilder: APIRequestBuilder = APIRequestBuilder()) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    
    func loadCharacters() async throws -> Characters {
        do {
            let request = try requestBuilder.builRequest(endPoint: .characters)
            let characters = try await makeRequest(request: request)
            return characters
        } catch {
            print("Hubo un error al cargar los characters: \(error)")
            throw error
        }
    }
    
    
    private func makeRequest(request: URLRequest) async throws -> Characters {
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error en la respuesta del servidor")
                throw APIErrorResponse.errorFromApi(statusCode: -1)
            }
            // nos aseguramos que sea 200
            guard httpResponse.statusCode == 200 else {
                print("Error en la respuesta del servidor. Código: \(httpResponse.statusCode)")
                throw APIErrorResponse.errorFromApi(statusCode: httpResponse.statusCode)
            }
            // Decoficamos los datos llegados del Data
            let characters = try JSONDecoder().decode(Characters.self, from: data)
            return characters
            
        } catch {
            print("Error en la petición: \(error)")
            throw error // Relanzar el error para que lo maneje el llamador
        }
        
    }
    
}
