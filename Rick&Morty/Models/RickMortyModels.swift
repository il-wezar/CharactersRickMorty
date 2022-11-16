//
//  RickMortyModels.swift
//  Rick&Morty
//
//  Created by Illia Wezarino on 15.09.2022.
//

import Foundation

struct RickMortyModels: Codable {
    var info: RickMortyInfo
    var results: [RickMortyModel]
    
}

struct RickMortyModel: Codable {
    
    let image: String
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: RickMortyOrigin
    let location: RickMortyLocation
    
}

struct RickMortyOrigin: Codable {
    let name: String
    let url: String
}

struct RickMortyLocation: Codable {
    let name: String
    let url: String
}

struct RickMortyInfo: Codable {
    let next: String?
    let prev: String?
}
