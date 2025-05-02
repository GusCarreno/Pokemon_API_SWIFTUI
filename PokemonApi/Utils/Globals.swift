//
//  Globals.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import SwiftUI

func typeColor(typeName: String) -> Color {
    switch typeName.lowercased() {
    case "normal":    return Color(hex: "#A8A77A")
    case "fire":      return Color(hex: "#EE8130")
    case "water":     return Color(hex: "#6390F0")
    case "grass":     return Color(hex: "#7AC74C")
    case "electric":  return Color(hex: "#F7D02C")
    case "ice":       return Color(hex: "#96D9D6")
    case "fighting":  return Color(hex: "#C22E28")
    case "poison":    return Color(hex: "#A33EA1")
    case "ground":    return Color(hex: "#E2BF65")
    case "flying":    return Color(hex: "#A98FF3")
    case "psychic":   return Color(hex: "#F95587")
    case "bug":       return Color(hex: "#A6B91A")
    case "rock":      return Color(hex: "#B6A136")
    case "ghost":     return Color(hex: "#735797")
    case "dragon":    return Color(hex: "#6937FF")
    case "dark":      return Color(hex: "#705746")
    case "steel":     return Color(hex: "#B7B7CE")
    case "fairy":     return Color(hex: "#D685AD")
    default:          return Color.gray 
    }
}
