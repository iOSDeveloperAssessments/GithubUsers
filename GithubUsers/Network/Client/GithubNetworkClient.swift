//
//  GithubNetworkClient.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

protocol GithubAPI {
  func users(at since: Int) async throws -> [GithubUser]
}

@Observable
class GithubNetworkClient {
  private let networkService: NetworkServiceProtocol

  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
}

extension GithubNetworkClient: GithubAPI {
  func users(at since: Int = .zero) async throws -> [GithubUser] {
    print("Loading next users at \(since)")

    let response: [GithubUserResponse] = try await networkService.request(from: UsersEndpoint(since: since))

    return response.compactMap { GithubUserAdapter(response: $0).adapt() }
  }
}
