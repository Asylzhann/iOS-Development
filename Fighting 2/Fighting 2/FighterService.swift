//
//  File.swift
//  Fighting 2
//
//  Created by Assylzhan on 28.11.2025.
//

import Foundation

struct FighterService {
    func fetchFighter(_ randomId: Int) async throws -> FighterModel {
        let urlString = "https://akabab.github.io/superhero-api/api/id/\(randomId).json"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            print(response)
            let fighterModel = try JSONDecoder().decode(FighterModel.self, from: data)
            return fighterModel
        } catch { throw error }
    }
}

enum NetworkError: Error {
    case invalidURL
}
