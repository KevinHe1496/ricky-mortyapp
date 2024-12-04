//
//  CharactersListViewModel.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import Foundation

enum CharacterState {
    case loading
    case success
    case error
}

final class CharactersListViewModel {
    
    private let useCase: CharactersUseCaseProtocol
    
    var onStateChanged = Binding<CharacterState>()
    private(set) var characters: [ResultsCharacters] = []
    
    init(useCase: CharactersUseCaseProtocol = CharactersUseCase()) {
        self.useCase = useCase
        
        Task(priority: .high) {
            await getCharacters()
        }
    }
    
    func getCharacters() async {
        onStateChanged.update(newValue: .loading)
        do {
            let data = try await useCase.loadCharacters()
            DispatchQueue.main.async {
                self.characters = data.results
                self.onStateChanged.update(newValue: .success)
            }
        } catch {
            print("Error al cargar los personajes en el VM: \(error.localizedDescription)")
            self.onStateChanged.update(newValue: .error)
        }
    }
}
