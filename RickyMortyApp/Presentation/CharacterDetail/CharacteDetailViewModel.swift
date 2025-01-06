//
//  CharacteDetailViewModel.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 6/1/25.
//

import Foundation

final class CharacteDetailViewModel {
    
    var onStateChanged = Binding<CharacterState>()
    private(set) var singleCharacter: ResultsCharacters
    
    init(singleCharacter: ResultsCharacters) {
        self.singleCharacter = singleCharacter
    }
    
}
