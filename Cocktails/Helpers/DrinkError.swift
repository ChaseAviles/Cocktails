//
//  DrinkError.swift
//  Cocktails
//
//  Created by Johnathan Aviles on 1/27/21.
//

import Foundation

enum DrinkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        
        case .invalidURL:
            return "Unable to reach server with URL provided."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "Unable to turn data to an image."
        }
    }
}
