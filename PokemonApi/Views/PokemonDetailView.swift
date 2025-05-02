//
//  PokemonDetailView.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import SwiftUI
import Foundation

struct PokemonDetailView: View {
    let pokemon: PokemonListItem
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: PokemonDetailViewModel

    init(pokemon: PokemonListItem) {
         self.pokemon = pokemon
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemonURL: URL(string: pokemon.url)!))
    }

    var body: some View {
        ScrollView {
            if let detail = viewModel.detail {
                VStack(spacing: 16) {

                    AsyncImage(url: detail.sprites.other.officialArtwork.front_default) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(height: 200)

                    HStack {
                        ForEach(detail.types, id: \.type.name) { type in
                            Text(type.type.name.capitalized)
                                .padding(8)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }

                    HStack {
                        VStack {
                            Text("\(Double(detail.weight) / 10, specifier: "%.1f") kg")
                                .bold()
                            Text("Peso")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Text("\(Double(detail.height) / 10, specifier: "%.1f") m")
                                .bold()
                            Text("Altura")
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal, 32)

                    Text(viewModel.spanishFlavorText)
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundColor(Color(hex: "#AAAAAA"))

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Estadísticas")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01426A"))
                        ForEach(detail.stats, id: \.stat.name) { stat in
                            HStack {
                                Text(stat.stat.name.capitalized)
                                    .frame(width: 100, alignment: .leading)
                                ProgressView(value: Float(stat.base_stat), total: 100)
                                    .accentColor(.green)
                                    .frame(height: 10)
                                Text(String(format: "%03d", stat.base_stat))
                                    .frame(width: 40, alignment: .trailing)
                            }
                        }
                    }
                    .padding()
                }
            } else if viewModel.isLoading {
                ProgressView("Cargando…")
            } else {
                Text(viewModel.errorMessage ?? "Error desconocido")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image("back")
                    Text("#\(pokemon.name.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#01426A"))
                }
                .onTapGesture {
                    dismiss()
                }
                .foregroundColor(Color(hex: "#01426A"))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("#\(pokemon.idFormatted)")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#AAAAAA"))
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
}
