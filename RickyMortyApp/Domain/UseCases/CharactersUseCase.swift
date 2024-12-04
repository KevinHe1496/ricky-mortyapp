//
//  CharactersUseCase.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 2/12/24.
//

import Foundation

protocol CharactersUseCaseProtocol {
    var repo: CharactersRepositoryProtocol { get set }
    func loadCharacters() async throws -> Characters
}


final class CharactersUseCase: CharactersUseCaseProtocol {
    
    var repo: CharactersRepositoryProtocol

    
    init(repo: CharactersRepositoryProtocol = CharactersRepository(network: APIProvider())) {
        self.repo = repo
    }
    
    func loadCharacters() async throws -> Characters {
        await repo.getCharacters()
    }
    
    
}
