//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Illia Wezarino on 15.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var rickMortyInfo: RickMortyModels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupSubview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollection()
    }
}

extension ViewController {
    
    func setupSubview() {
        title = "Rick&Morty"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(nextPage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Prev",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(prevPage))
        
        let navBar = self.navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        navBar?.barTintColor = UIColor.black
        navBar?.barStyle = .black
        navBar?.tintColor = .white
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white ]
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 1,
                                 height: view.bounds.width / 2 - 2)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 1
        
        view.backgroundColor = .cyan
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.backgroundColor = .black
        collectionView.register(CellViewController.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func setupCollection() {
        collectionView!.frame = view.bounds
    }
    
    @objc func nextPage() {
        page = rickMortyInfo?.info.next ?? page
        getData()
    }

    @objc func prevPage() {
        if page != "https://rickandmortyapi.com/api/character/?page=1" {
            page = rickMortyInfo?.info.prev ?? page
            getData()
        }
    }
}

//MARK: - extensions DataSource and Delegate

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let rickMortyInfo = rickMortyInfo else {return}
        
        let vc = CellScreen(with: (image: rickMortyInfo.results[indexPath.row].image,
                                   name: rickMortyInfo.results[indexPath.row].name,
                                   status: rickMortyInfo.results[indexPath.row].status,
                                   species: rickMortyInfo.results[indexPath.row].species,
                                   gender: rickMortyInfo.results[indexPath.row].gender,
                                   origin: rickMortyInfo.results[indexPath.row].origin.name,
                                   location: rickMortyInfo.results[indexPath.row].location.name))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rickMortyInfo?.results.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        (cell as? CellViewController)?.setData(rickMortyInfo?.results[indexPath.row].name ?? "", image: rickMortyInfo?.results[indexPath.row].image ?? "")
        
        return cell
    }
    
    private func getData() {
        Request.NetworkManager.fire { [weak self] rickMortyInfo in
            self?.rickMortyInfo = rickMortyInfo
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
    }
    
}
