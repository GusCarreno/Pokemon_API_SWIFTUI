//
//  PokemonListViewModel.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import Foundation

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    let baseURL = "https://pokeapi.co/api/v2/pokemon"
    let session: URLSession

    init(session: URLSession = .shared) {
            self.session = session
            Task {
                await fetchPokemonList()
            }
        }

    func fetchPokemonList() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: baseURL) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
            self.pokemonList = decoded.results
            self.isLoading = false
        } catch {
            self.errorMessage = "Error: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}
