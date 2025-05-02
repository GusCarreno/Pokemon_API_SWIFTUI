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
                    ZStack {
                        // Background for the image
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.green)
                            .padding(.top,90)
                            .padding(.horizontal)
                        
                        AsyncImage(url: detail.sprites.other.home.front_default) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                            } placeholder: {
                                ProgressView()
                                    .frame(height: 180)
                            }
                            .padding()
                    

                    HStack {
                        ForEach(detail.types, id: \.type.name) { type in
                            Text(type.type.name.capitalized)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .foregroundColor(typeColor(typeName: type.type.name)) // Use the typeColor function
                                .background(Color(hex: "#F8F8F8"))
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                      }
                      .padding(.top, 200)
                    }
                }
                    HStack {
                        HStack {
                            Image("peso")
                                .foregroundColor(.blue)
                            VStack {
                                Text("\(Double(detail.weight) / 10, specifier: "%.1f") kg")
                                    .bold()
                                    .foregroundColor(Color(hex: "#01426A"))
                                Text("Peso")
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "#2C85BC"))
                            }
                        }
                        .frame(width: 150) // Adjust as needed for spacing
                        Divider()
                        HStack {
                            Image("altura")
                                .foregroundColor(.blue) // Use the blue color from the image
                        VStack {
                          
                            Text("\(Double(detail.height) / 10, specifier: "%.1f") m")
                                .bold()
                                .foregroundColor(Color(hex: "#01426A"))
                            Text("Altura")
                                .font(.caption)
                                .foregroundColor(Color(hex: "#2C85BC"))
                        }
                        }
                        .frame(width: 150) // Adjust as needed for spacing
                    }
                    .padding(5) // Add padding for spacing around the content
                    .background(Color.white) // White background for the container
                    .cornerRadius(10) // Rounded corners for the container
                    .shadow(radius: 2) // Subtle shadow

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
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(hex: "#65D498").opacity(0.5))
                                        .frame(height: 10)
                                    
                                    // Foreground for the ProgressView with gradient
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color(hex: "#00A500"), Color(hex: "#009444")]), // Green gradient
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: CGFloat(stat.base_stat) / 100 * 160, height: 10)
                                        .animation(.default, value: stat.base_stat)
                                }
                                .frame(width: 160, height: 10)
                                Text(String(format: "%03d", stat.base_stat))
                                    .frame(width: 40, alignment: .trailing)
                            }
                        }
                    }
                    .padding()
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
        .navigationBarBackButtonHidden(true)
        .background(Color(hex: "#F8F8F8"))
    }
}
