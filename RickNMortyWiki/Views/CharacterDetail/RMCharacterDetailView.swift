//
//  RMCharacterDetailView.swift
//  RickNMortyWiki
//
//  Created by Pongthorn Chumpoo on 13/12/2566 BE.
//

import UIKit

final class RMCharacterDetailView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    init(frame:CGRect,viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        self.collectionView?.dataSource = self.viewModel
        self.collectionView?.delegate = self.viewModel
        addSubviews(collectionView,spinner)
        setUpContraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupport")
    }
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private func setUpContraints(){
        
        guard let collectionView = collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex:Int) -> NSCollectionLayoutSection {
        
        let sectionType = viewModel.sections
        switch sectionType[sectionIndex]{
        case .photo:
            return viewModel.createPhotoSection()
        case .information:
            return viewModel.createInformationSection()
        case .episode:
            return viewModel.createEpisodeSection()
        }
        
    }
    
}

