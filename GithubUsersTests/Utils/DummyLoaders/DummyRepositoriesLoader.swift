//
//  DummyRepositoriesLoader.swift
//  GithubUsersTests
//
//  Created by David Alarcon on 10/7/24.
//

import Foundation
@testable import GithubUsers

class DummyRepositoriesLoader {
  static func loadRepositories() throws -> [RepositoryResponse] {
    guard let url = Bundle(for: self).url(forResource: "Repositories", withExtension: "json") else {
      throw NSError(domain: "DummyRepositoriesLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

    return try decoder.decode([RepositoryResponse].self, from: data)
  }
}
