//
//  CharactersListViewModel.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import Foundation
import Combine

enum CharacterState {
    case loading
    case success
    case error(reason: String)
}

final class CharactersListViewModel: ObservableObject {
    
    private let useCase: CharactersUseCaseProtocol
    
    @Published var onStateChanged = Binding<CharacterState>()
    @Published private(set) var characters: [ResultsCharacters] = []
    
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
            self.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
        }
    }
}
