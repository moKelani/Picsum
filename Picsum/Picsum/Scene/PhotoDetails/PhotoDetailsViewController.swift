//
//  PhotoDetailsViewController.swift
//  Picsum
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: UIViewController {

    var presenter: PhotoDetailsPresenterInput?
    
    
    let photoImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.image  = UIImage(named: "photo-placeholder")
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.contentMode = .scaleAspectFit
       imageView.layer.cornerRadius = 8
       imageView.clipsToBounds = true
       return imageView
   }()
    
    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.updatePhotoDetails()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIImage(named: "photo-placeholder")?.averageColor
        view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
        
    }

}
extension PhotoDetailsViewController: PhotoDetailsPresenterOutput {
    func updateData(error: Error) {
        switch error as? PicsumError {
        case .noResults:
            self.emptyState(emptyPlaceHolderType: .noResults)
        default:
            self.emptyState(emptyPlaceHolderType: .error(message: error.localizedDescription))
        }
    }
    
    func updateData(photo: PicsumPhoto) {
        if let path = photo.download_url, let url = URL(string: path) {
            
            let resource = ImageResource(downloadURL: url)
            photoImageView.kf.setImage(with: resource, placeholder: UIImage(named: "photo-placeholder"), options: nil)
            
            
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                    self.view.backgroundColor = value.image.averageColor
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
        }
        
        title = photo.author ?? ""
        
    }
    
    
}
