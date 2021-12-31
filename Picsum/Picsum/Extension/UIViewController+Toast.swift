//
//  UIViewController+Toast.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//


import UIKit

enum Theme {
    case success
    case error
}

extension UIViewController {

    func showAlert(message : String, font: UIFont = .systemFont(ofSize: 12.0), theme: Theme) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: self.view.frame.size.width-32, height: 46))
        switch theme {
        case .success:
            toastLabel.backgroundColor = UIColor.navyBlue
        case .error:
            toastLabel.backgroundColor = UIColor.basicRed
        }
        
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
