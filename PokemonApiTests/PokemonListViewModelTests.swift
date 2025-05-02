import XCTest
@testable import YourAppModuleName

final class PokemonListViewModelTests: XCTestCase {
    func testFetchPokemonListSuccess() async {
        let mockSession = MockURLSession(success: true)
        let viewModel = PokemonListViewModel(session: mockSession)

        // Wait a bit for async init
        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.pokemonList.count, 2)
        XCTAssertEqual(viewModel.pokemonList.first?.name, "bulbasaur")
    }

    func testFetchPokemonListFailure() async {
        let mockSession = MockURLSession(success: false)
        let viewModel = PokemonListViewModel(session: mockSession)

        try? await Task.sleep(nanoseconds: 500_000_000)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.pokemonList.isEmpty)
    }
}
