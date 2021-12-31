//
//  BasePresenterIO.swift
//  Picsum
//
//  Created by Mohamed Kelany on 31/12/2021.
//

import UIKit

protocol BasePresenterInput: AnyObject {
    func viewDidLoad()
}

extension BasePresenterInput {
    func viewDidLoad() {}
}

protocol BaseDisplayLogic: AnyObject {
    func handle(error: PicsumError)
    func showError(error: Error)
    func showError(message: String)
    func showSuccess(message: String)
}

protocol Loading {
    func showLoading()
    func hideLoading()
}

protocol BasePresenterOutput: BaseDisplayLogic, Loading { }

extension BaseDisplayLogic where Self: UIViewController {

    func handle(error: PicsumError) {
        showError(error: error)
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(message: error.localizedDescription, theme: .error)
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message: message, theme: .error)
        }
    }

    func showSuccess(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message: message, theme: .success)
        }
    }

}

extension UIViewController: BasePresenterOutput {
    func showLoading() {
        DispatchQueue.main.async {
            self.view.showLoadingIndicator()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.view.dismissLoadingIndicator()
        }
    }
}

