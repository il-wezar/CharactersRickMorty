//
//  CellScreen.swift
//  Rick&Morty
//
//  Created by Illia Wezarino on 19.09.2022.
//

import UIKit

class CellScreen: UIViewController {
    
    private var info: (image: String,
                       name: String,
                       status: String,
                       species: String,
                       gender: String,
                       origin: String,
                       location: String)?
    
    private let infoLabel = UILabel()
    private let imageView = CustomImageView()
    
    init(with info: (image: String, name: String, status: String, species: String, gender: String, origin: String, location: String)) {
        super.init(nibName: nil, bundle: nil)
        self.info = info
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupSubview()
        addConstraints()
    }
}

private extension CellScreen {
    
    private func setupSubview() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        title = info?.name
        
        infoLabel.text = """
        Name: \(info?.name ?? "")
        Status: \(info?.status ?? "")
        Species: \(info?.species ?? "")
        Gender: \(info?.gender ?? "")
        Origin: \(info?.origin ?? "")
        Location: \(info?.location ?? "")
        """
        infoLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
        infoLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(infoLabel)
        
        imageView.layer.cornerRadius = 150
        imageView.clipsToBounds = true
        imageView.downloadImageFrom(urlString: info?.image ?? "", imageMode: .scaleAspectFit)
        view.addSubview(imageView)
        
        view.subviews.forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: - Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
