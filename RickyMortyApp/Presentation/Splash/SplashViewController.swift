//
//  SplashViewController.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 12/10/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SplashViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }

    private func bind() {
        viewModel.onStateChange.bind { [weak self] state in
            switch state{
                
            case .loading:
                self?.setAnimation(true)
            case .error:
                break
            case .ready:
                self?.setAnimation(false)
                self?.present(CharactersListBuilder().build(), animated: true)
            }
        }
    }
    
    private func setAnimation(_ animating: Bool) {
        switch spinner.isAnimating{
            
        case true where !animating:
            spinner.stopAnimating()
        case false where animating:
            spinner.startAnimating()
        default:
            break
        }
    }

}
