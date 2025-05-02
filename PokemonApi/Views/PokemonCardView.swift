//
//  PokemonCardView.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: PokemonListItem
    
    var body: some View {
            VStack {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: pokemon.imageUrl) { phase in
                      switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 80)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(.top, 20) 
                        case .failure:
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.gray)
                                .frame(width: 80, height: 80)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text("#\(pokemon.idFormatted)")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#AAAAAA"))
                        .padding(4)
                }
                
                Text(pokemon.name.capitalized)
                    .font(.headline.bold())
                    .foregroundColor(Color(hex: "#01426A"))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 4)
            .frame(width: 130)
        }
}
