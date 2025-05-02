//
//  PokemonListViewModelTests.swift
//  PokemonApi
//
//  Created by Mr. G Carreño on 1/5/25.
//


import XCTest
@testable import PokemonApi
import Foundation

final class PokemonListViewModelTests: XCTestCase {

    func testFetchPokemonListSuccess() async {
        let viewModel = await PokemonListViewModel()
        await viewModel.fetchPokemonList()

       // XCTAssertFalse(viewModel.pokemonList.isEmpty, "Pokemon list should not be empty after fetching.")
       // XCTAssertNil(viewModel.errorMessage)
    }

    func testInvalidURL() async {
        let viewModel = await PokemonListViewModel()
        viewModel.baseURL = "invalid-url" 
        await viewModel.fetchPokemonList()

        //XCTAssertNotNil(viewModel.errorMessage)
        //XCTAssertTrue(viewModel.pokemonList.isEmpty)
    }
}
