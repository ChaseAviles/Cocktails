//
//  UIViewControllerExtension.swift
//  Cocktails
//
//  Created by Johnathan Aviles on 1/27/21.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        // Alert from error.
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        // Dismiss action.
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        // Present alert.
        present(alertController, animated: true)
    }
}

