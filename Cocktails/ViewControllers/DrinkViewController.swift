//
//  DrinkViewController.swift
//  Cocktails
//
//  Created by Johnathan Aviles on 1/27/21.
//

import UIKit

class DrinkViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    @IBOutlet weak var drinkTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }

    // MARK: - Methods
    func fetchandUpdateViews(drink: Drink) {
            DrinkController.fetchDrinkImage(drink: drink) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let thumbnail):
                        self.drinkTextLabel.text = drink.strDrink
                        self.drinkImageView.image = thumbnail
                        self.drinkDescriptionLabel.text = drink.strInstructions
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                    }
                }
            }
        }
}

extension DrinkViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        DrinkController.fetchDrinks(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let drink):
                    self.fetchandUpdateViews(drink: drink)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }

    }
}

