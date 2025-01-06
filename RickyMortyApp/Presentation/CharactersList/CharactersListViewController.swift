//
//  CharactersListViewController.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import UIKit
import Combine

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let viewModel: CharactersListViewModel
    var searchController: UISearchController!
    var filteredCharacter: [ResultsCharacters] = [ResultsCharacters]()
    var suscriptors = Set<AnyCancellable>()
    
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharactersListViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lista de Personajes"
        ConfigSearchBar()
        setUpTableView()
        BindingUI()
        
    }
    
    private func ConfigSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self // Asigna el delegado
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar personaje"
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
                self.filteredCharacter = self.viewModel.characters
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
        return filteredCharacter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        
        let character = filteredCharacter[indexPath.row]
        
        cell.nameLabel.text = character.name
        cell.speciesLabel.text = character.species
        
        if let urlPhoto = URL(string: character.image)  {
            cell.characterImageView.loadImageRemote(url: urlPhoto)
        }
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        print("Has seleccionado a: \(character)")
        let VC = CharacterDetailViewController(viewModel: CharacteDetailViewModel(singleCharacter: character))
        navigationController?.pushViewController(VC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension CharactersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            filteredCharacter = viewModel.characters
        } else {
            filteredCharacter = viewModel.characters.filter({ character in
                character.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCharacter = viewModel.characters // Restaura la lista original
        tableView.reloadData()          // Recarga la tabla
    }
}
