//
//  CellViewController.swift
//  Rick&Morty
//
//  Created by Illia Wezarino on 15.09.2022.
//

import UIKit

class CellViewController: UICollectionViewCell {
    
    private let cellLabel = UILabel()
    private let cellImage = CustomImageView()
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupSubview()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension CellViewController {
    
    private func setupSubview() {
        contentView.backgroundColor = .black
        
        cellLabel.textAlignment = NSTextAlignment.center
        cellLabel.textColor = .white
        cellLabel.contentMode = .scaleAspectFit
        cellLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(cellLabel)
        
        contentView.addSubview(cellImage)
        
        contentView.subviews.forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setData(_ text: String, image: String) {
        cellLabel.text = text
        cellImage.downloadImageFrom(urlString: image, imageMode: .scaleAspectFit)
    }
    
    // MARK: - Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
}
