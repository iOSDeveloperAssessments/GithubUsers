//
//  DummyCharactersLoader.swift
//  RickAndMorty
//
//  Created by David Alarcon on 2/5/24.
//

import Foundation
@testable import GithubUsers

class DummyUsersLoader {
  static func loadUsers() throws -> [GithubUserResponse] {
    guard let url = Bundle(for: self).url(forResource: "GithubUsers", withExtension: "json") else {
      throw NSError(domain: "DummyUsersLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

    return try decoder.decode([GithubUserResponse].self, from: data)
  }
}
