//
//  SplashBuilder.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import UIKit


final class SplashBuilder {
    func build() -> UIViewController {
        let viewModel = SplashViewModel()
        
        return SplashViewController(viewModel: viewModel)
    }
}


