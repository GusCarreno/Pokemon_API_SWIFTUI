//
//  PokemonDetailViewModel.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import Foundation

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var species: PokemonSpecies?
    @Published var isLoading = true
    @Published var errorMessage: String?

    let pokemonURL: URL

    init(pokemonURL: URL) {
        self.pokemonURL = pokemonURL
        Task { await fetchDetails() }
    }

    func fetchDetails() async {
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from: pokemonURL)
            let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
            self.detail = detail

            let speciesURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(detail.id)/")!
            let (speciesData, _) = try await URLSession.shared.data(from: speciesURL)
            let species = try JSONDecoder().decode(PokemonSpecies.self, from: speciesData)
            self.species = species

            isLoading = false
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error loading Pokémon"
                self.isLoading = false
            }
        }
    }

    var spanishFlavorText: String {
        species?.flavor_text_entries.first(where: { $0.language.name == "es" })?.flavor_text.replacingOccurrences(of: "\n", with: " ") ?? "Sin descripción"
    }
}
