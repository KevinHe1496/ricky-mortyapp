//
//  UrlRequest.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 21/11/24.
//

import Foundation

final class UrlRequest {

     func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else{
                return
            }
            print(data)
            do {
                let characters = try JSONDecoder().decode(Characters.self, from: data)
                print(characters)
            } catch let error as NSError{
                print("hubo un problema en cargar \(error.localizedDescription)")
            }
        }
    }
}
