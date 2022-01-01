//
//  PhotoCollectionCell.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell, CellReusable {

     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image  = UIImage(named: "photo-placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let photoAuthorNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor  = UIColor.black.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
       return label
   }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.kf.cancelDownloadTask()
        photoImageView.image = nil
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        addSubview(photoAuthorNameLabel)

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoAuthorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoAuthorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoAuthorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoAuthorNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }

    func configCell(photo: PicsumPhoto) {
        if let path = photo.download_url {
            photoImageView.kf.setImage(with: URL(string: path), placeholder: UIImage(named: "photo-placeholder"), options: nil, completionHandler: nil)
        }
        
        if let authorName = photo.author {
            photoAuthorNameLabel.text = authorName
        }else {
            photoAuthorNameLabel.isHidden = true
        }
    }
}

