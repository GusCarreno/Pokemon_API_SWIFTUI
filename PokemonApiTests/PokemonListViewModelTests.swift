//
//  PokemonListViewModelTests.swift
//
//  Created by Mr. G Carreño on 1/5/25.
//

import XCTest
@testable import PokemonApi
import Foundation

@MainActor
final class PokemonListViewModelTests: XCTestCase {
    func testFetchPokemonListSuccess() async {
        let mockSession = MockURLSession(success: true)
        let viewModel = PokemonListViewModel(session: mockSession)

        // Wait a bit for async init
        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.pokemonList.count, 20)
        XCTAssertEqual(viewModel.pokemonList.first?.name, "bulbasaur")
    }

    func testFetchPokemonListFailure() async {
        let mockSession = MockURLSession(success: false)
        let viewModel = PokemonListViewModel(session: mockSession)

        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertFalse(viewModel.isLoading)
    }
}
