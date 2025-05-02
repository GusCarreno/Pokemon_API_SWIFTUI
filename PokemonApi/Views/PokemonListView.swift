//
//  PokemonListView.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
        @State private var searchText = ""
    
       //search in the pokemonList previus fetch
        var filteredPokemon: [PokemonListItem] {
            if searchText.isEmpty {
                return viewModel.pokemonList
            } else {
                return viewModel.pokemonList.filter {
                    $0.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

        var body: some View {
            NavigationView {
                VStack(alignment: .leading) {
                    HStack {
                        Image("logo")
                            .foregroundColor(.blue)
                        Text("Pokédex")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(hex: "#005FFF"))
                    }
                    .padding(.top, 20)

                    Text("¡Hola, **bienvenido**!")
                        .font(.title3)
                        .padding(.top, 4)

                    // Search bar
                    HStack {
                        TextField("Buscar", text: $searchText)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(hex: "#F8F8F8").opacity(0.1))
                            .clipShape(Capsule())

                        Button(action: {
                            // handle search
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.systemBackground))
                                .padding(5)
                                .background(Color.yellow)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(hex: "#7C7C7C"), lineWidth: 1)
                    )
                    // Grid view
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(filteredPokemon, id: \.id) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    PokemonCardView(pokemon: pokemon)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(true)
                .background(Color(hex: "#F8F8F8"))
            }
            .task {
                await viewModel.fetchPokemonList()
            }
        }
    }
