//
//  CharactersRepository.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 3/12/24.
//

import Foundation

final class CharactersRepository: CharactersRepositoryProtocol {
    
    private var network: APIProviderProtocol
    
    init(network: APIProviderProtocol = APIProvider()) {
        self.network = network
    }
    
    func getCharacters() async -> Characters {
        
        do {
            return try await network.loadCharacters()
        } catch {
            print("Error al obtener los personajes \(error.localizedDescription)")
            return Characters(results: [ResultsCharacters]())
        }
        
    }
    
    
}
