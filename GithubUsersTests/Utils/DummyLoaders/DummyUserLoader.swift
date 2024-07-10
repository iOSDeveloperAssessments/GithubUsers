//
//  DummyUserLoader.swift
//  GithubUsersTests
//
//  Created by David Alarcon on 10/7/24.
//

import Foundation
@testable import GithubUsers

class DummyUserLoader {
  static func loadUser() throws -> GithubUserResponse {
    guard let url = Bundle(for: self).url(forResource: "GithubUser", withExtension: "json") else {
      throw NSError(domain: "DummyUserLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

    return try decoder.decode(GithubUserResponse.self, from: data)
  }
}
