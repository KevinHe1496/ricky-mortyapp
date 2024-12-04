//
//  CharactersListViewController.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharactersListViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.title = "Lista de Personajes"
        BindingUI()
        
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CharacterCell.identifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: CharacterCell.identifier)
    }
    
    private func BindingUI() {
        viewModel.onStateChanged.bind { state in
            switch state {
                
            case .loading:
                print("cargando")
                self.spinner.startAnimating()
            case .success:
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            case .error:
                self.spinner.stopAnimating()
                print("Error al cargar los datos en el VC")
            }
        }
    }
    
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        
        let character = viewModel.characters[indexPath.row]
        
        cell.nameLabel.text = character.name
        cell.speciesLabel.text = character.species
        
        if let urlPhoto = URL(string: character.image)  {
            cell.characterImageView.loadImageRemote(url: urlPhoto)
        }
        
        
        
        return cell
    }
    
    
}
