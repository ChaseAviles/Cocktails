//
//  DrinkController.swift
//  Cocktails
//
//  Created by Johnathan Aviles on 1/27/21.
//

import UIKit

class DrinkController {
    
    static let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")
    static let searchEndpoint = "search"
    static let phpExtension = "php"
    
    static func fetchDrinks(searchTerm: String, completion: @escaping (Result<Drink,DrinkError>) -> Void) {
        guard let baseURL = baseURL else { return }
                let searchURL = baseURL.appendingPathComponent(searchEndpoint)
                let phpURL = searchURL.appendingPathExtension(phpExtension)
                var components = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
                
                let drinksQuery = URLQueryItem(name: "s", value: searchTerm)
                components?.queryItems = [drinksQuery]
                guard let finalURL = components?.url else { return }
                print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print(error.localizedDescription)
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let object = topLevelObject.drinks[0]
                completion(.success(object))
            }catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print(error.localizedDescription)
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
        
    }
    
    
    static func fetchDrinkImage(drink: Drink, completion: @escaping (Result<UIImage,DrinkError>) -> Void) {
            
            let url = drink.strDrinkThumb
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("===== ERROR =====")
                    print("Function: \(#function)")
                    print(error)
                    print("Description: \(error.localizedDescription)")
                    print("===== ERROR =====")
                    return completion(.failure(.thrownError(error)))
                }
                guard let data = data else { return completion(.failure(.noData)) }
                
                guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
                completion(.success(thumbnail))
            }.resume()
        }
    
}
