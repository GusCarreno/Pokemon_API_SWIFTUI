//
//  PokedexUITests.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//


import XCTest

final class PokedexUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
}
