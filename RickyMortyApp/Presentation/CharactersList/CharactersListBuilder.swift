//
//  CharactersListBuilder.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//


import UIKit


final class CharactersListBuilder {
    func build() -> UIViewController {
        
        let viewModel = CharactersListViewModel()
        let viewController = CharactersListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
}
