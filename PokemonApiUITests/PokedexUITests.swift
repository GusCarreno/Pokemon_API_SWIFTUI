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

    func testPokemonGridLoaded() {
        let charizard = app.staticTexts["Charizard"]
        XCTAssertTrue(charizard.waitForExistence(timeout: 5), "Charizard should appear in the grid.")
    }

    func testTapPokemonOpensDetail() {
        let bulbasaur = app.staticTexts["Bulbasaur"]
        XCTAssertTrue(bulbasaur.waitForExistence(timeout: 5))
        bulbasaur.tap()

        // Check detail screen shows correct name
        let detailTitle = app.staticTexts["Bulbasaur"]
        XCTAssertTrue(detailTitle.exists)
    }
}
