//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickNMortyWiki
//
//  Created by Pongthorn Chumpoo on 5/12/2566 BE.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable,Equatable {
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, imageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = imageURL
    }
    
    public var CharacterStatus:String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void){
        
        guard let url = characterImageURL else { return completion(.failure(URLError(.badURL)))}
        
        RMImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable

        static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(characterName)
            hasher.combine(characterStatus)
            hasher.combine(characterImageURL)
        }
    
}
