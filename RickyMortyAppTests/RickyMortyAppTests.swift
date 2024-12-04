//
//  RickyMortyAppTests.swift
//  RickyMortyAppTests
//
//  Created by Kevin Heredia on 12/10/24.
//

import XCTest
@testable import RickyMortyApp

final class RickyMortyAppTests: XCTestCase {

    func test_CharactersModel() {
        //When
        let sut = ResultsCharacters(id: 1, name: "Rick", species: "Human", image: "Photo")
        
        //Then
        XCTAssertEqual(sut.name, "Rick")
        
        
    }

}
