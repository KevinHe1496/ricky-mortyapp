//
//  CharactersRepositoryProtocol.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 3/12/24.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func getCharacters() async -> Characters
}
