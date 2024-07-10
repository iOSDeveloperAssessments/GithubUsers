//
//  GithubNetworkClient.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

protocol GithubAPI {
  func users(at since: Int) async throws -> [GithubUser]
  func user(id: Int) async throws -> GithubUser
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

  func user(id: Int) async throws -> GithubUser {
    let response: GithubUserResponse = try await networkService.request(from: UserEndpoint(id: id))
    var user = GithubUserAdapter(response: response).adapt()

    if let repositoresUrlString = response.repos_url {
      let repositoryResponse: [RepositoryResponse] = try await networkService.request(from: RepositoriesEndpoint(urlString: repositoresUrlString))
      user.repositories = repositoryResponse.compactMap { RepositoryAdapter(response: $0).adapt() }
    }

    if let followersUrlString = response.followers_url {
      let followersResponse: [GithubUserResponse] = try await networkService.request(from: FollowersEndpoint(urlString: followersUrlString))
      user.followers = followersResponse.compactMap { GithubUserAdapter(response: $0).adapt() }
    }

    return user
  }
}
