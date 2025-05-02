//
//  Extensions.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//

import SwiftUI

extension Color {
  
    init(hex: String) {
        var cleanString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cleanString.hasPrefix("#") {
            cleanString.remove(at: cleanString.startIndex)
        }

        if cleanString.count == 6 {
            var rgbValue: UInt64 = 0
            Scanner(string: cleanString).scanHexInt64(&rgbValue)

            self.init(
                red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: Double(rgbValue & 0x0000FF) / 255.0
            )
            return
        }
        //format #RGB
        if cleanString.count == 3{
            var rgbValue: UInt64 = 0
            Scanner(string: cleanString).scanHexInt64(&rgbValue)
            
            let r = (rgbValue & 0xF00) >> 8
            let g = (rgbValue & 0x0F0) >> 4
            let b = rgbValue & 0x00F
            
            self.init(
                red: Double(r * 0x11) / 255.0,
                green: Double(g * 0x11) / 255.0,
                blue: Double(b * 0x11) / 255.0
            )
            return
        }

        self = .gray // default
    }
}
