//
//  PokemonListItem.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import Foundation

// Single Pokémon item in the list
struct PokemonListItem: Decodable, Identifiable {
    let name: String
    let url: String

    var id: Int {
        Int(url.split(separator: "/").last!) ?? 0
    }

    var idFormatted: String {
        String(format: "%03d", id)
    }

    var imageUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
}
