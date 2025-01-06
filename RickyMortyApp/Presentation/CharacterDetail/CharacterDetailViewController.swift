//
//  CharacterDetailViewController.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 6/1/25.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacterLabel: UILabel!
    @IBOutlet weak var detailCharacterLabel: UILabel!
    
    private var viewModel: CharacteDetailViewModel
    
    init(viewModel: CharacteDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CharacterDetailViewController.self), bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    private func updateUI() {

        nameCharacterLabel.text = viewModel.singleCharacter.name
        
        detailCharacterLabel.text = viewModel.singleCharacter.species
        statusLabel.text = viewModel.singleCharacter.status
        if viewModel.singleCharacter.status == "Alive" {
            statusLabel.textColor = .green
        } else {
            statusLabel.textColor = .red
        }
        
        genderLabel.text = viewModel.singleCharacter.gender
        
        if let urlPhoto = URL(string: viewModel.singleCharacter.image)  {
            imageCharacter.loadImageRemote(url: urlPhoto)

            imageCharacter.layer.borderWidth = 3.0

        }
    }
}

#Preview {
    CharacterDetailViewController(viewModel: CharacteDetailViewModel(singleCharacter: ResultsCharacters(id: 0, name: "Morty Smith", species: "Human", gender: "Male", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")))
}
