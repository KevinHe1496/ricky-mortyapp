//
//  SplashViewModel.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import Foundation


enum SplashState {
    case loading
    case error
    case ready
}

final class SplashViewModel {
    var onStateChange = Binding<SplashState>()
    
    func load() {
        onStateChange.update(newValue: .loading)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onStateChange.update(newValue: .ready)
        }
    }
}
