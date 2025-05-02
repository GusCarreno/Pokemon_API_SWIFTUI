//
//  PokemonDetail.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import Foundation

struct PokemonDetail: Decodable {
    struct TypeEntry: Decodable {
        struct TypeInfo: Decodable { let name: String }
        let type: TypeInfo
    }

    struct StatEntry: Decodable {
        struct StatInfo: Decodable { let name: String }
        let stat: StatInfo
        let base_stat: Int
    }

    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let sprites: Sprites
    let types: [TypeEntry]
    let stats: [StatEntry]

    struct Sprites: Decodable {
        let other: Other

        struct Other: Decodable {
            let home: Home

            enum CodingKeys: String, CodingKey {
                case home = "home"
            }

            struct Home: Decodable {
                let front_default: URL
            }
        }

        enum CodingKeys: String, CodingKey {
            case other
        }
    }
}

struct PokemonSpecies: Decodable {
    struct FlavorTextEntry: Decodable {
        let flavor_text: String
        let language: Language

        struct Language: Decodable {
            let name: String
        }
    }

    let flavor_text_entries: [FlavorTextEntry]
}
