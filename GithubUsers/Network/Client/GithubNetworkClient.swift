//
//  GithubNetworkClient.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

protocol GithubAPI {
  func users(at page: Int) async throws -> [GithubUser]
}

@Observable
class GithubNetworkClient {
  private let networkService: NetworkServiceProtocol

  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
}

extension GithubNetworkClient: GithubAPI {
  func users(at page: Int = .zero) async throws -> [GithubUser] {
    let response: GithubUsersResponse = try await networkService.request(from: UsersEndpoint(page: page))

    return response.users.compactMap { GithubUserAdapter(response: $0).adapt() }
  }
}
