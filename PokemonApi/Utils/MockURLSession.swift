//
//  PokemonListItem.swift
//  MockURLSession
//
//  Created by Mr. G Carreño on 1/5/25.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    let success: Bool

    init(success: Bool) {
        self.success = success
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if success {
            let json = """
            {
              "count": 2,
              "next": null,
              "previous": null,
              "results": [
                {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
                {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"}
              ]
            }
            """.data(using: .utf8)!

            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (json, response)
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
