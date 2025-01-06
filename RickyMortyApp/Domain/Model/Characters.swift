//
//  Characters.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import Foundation


struct Characters: Decodable, Equatable {
    let results: [ResultsCharacters]
}

struct ResultsCharacters: Decodable, Equatable {
    let id: Int
    let name: String
    let species: String
    let gender: String
    let status: String
    let image: String
}
