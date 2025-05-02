//
//  PokemonDetailView.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonListItem

    var body: some View {
        VStack {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .padding()

            AsyncImage(url: pokemon.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                case .failure:
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.gray)
                        .frame(width: 200, height: 200)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}
