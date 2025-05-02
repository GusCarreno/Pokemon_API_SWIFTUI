//
//  PokemonListResponse.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}
